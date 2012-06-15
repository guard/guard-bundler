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
      if bundle_need_refresh?
        ::Guard::UI.info 'Refresh bundle', :reset => true
        start_at = Time.now
        ::Bundler.with_clean_env do
          @result = system("bundle install#{" #{options[:cli]}" if options[:cli]}")
        end
        Notifier.notify(@result, Time.now - start_at)
        @result
      else
        UI.info 'Bundle already up-to-date', :reset => true
        Notifier.notify('up-to-date', nil)
        true
      end
    end

    def bundle_need_refresh?
      ::Bundler.with_clean_env do
        `bundle check`
      end
      $? == 0 ? false : true
    end

  end
end
