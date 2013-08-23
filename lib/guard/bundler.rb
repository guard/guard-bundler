# encoding: utf-8
require 'guard'
require 'guard/guard'
require 'bundler'

module Guard
  class Bundler < Guard
    autoload :Notifier, 'guard/bundler/notifier'

    def start
      refresh_bundle
    end

    def reload
      refresh_bundle
    end

    def run_all
      refresh_bundle
    end

    def run_on_additions(paths = [])
      refresh_bundle
    end

    def run_on_modifications(paths = [])
      refresh_bundle
    end

    def cli?
      !!options[:cli]
    end

    private

    def refresh_bundle
      start_at = Time.now
      result = bundle_check || bundle_install
      duration = Time.now - start_at
      case result
      when :bundle_already_up_to_date
        ::Guard::UI.info 'Bundle already up-to-date', :reset => true
      when :bundle_installed_using_local_gems
        ::Guard::UI.info 'Bundle installed using local gems', :reset => true
        Notifier.notify 'bundle_check_install', nil
      when :bundle_installed
        ::Guard::UI.info 'Bundle installed', :reset => true
        Notifier.notify true, duration
      else
        ::Guard::UI.info "Bundle can't be installed -- Please check manually", :reset => true
        Notifier.notify false, nil
      end
      result
    end

    def bundle_check
      gemfile_lock_mtime = File.exists?('Gemfile.lock') ? File.mtime('Gemfile.lock') : nil
      ::Bundler.with_clean_env do
        `bundle check`
      end
      return false unless $? == 0
      if gemfile_lock_mtime && gemfile_lock_mtime == File.mtime('Gemfile.lock')
        :bundle_already_up_to_date
      else
        :bundle_installed_using_local_gems
      end
    end

    def bundle_install
      ::Bundler.with_clean_env do
        system("bundle install#{" #{options[:cli]}" if options[:cli]}")
      end
      $? == 0 ? :bundle_installed : false
    end
  end
end
