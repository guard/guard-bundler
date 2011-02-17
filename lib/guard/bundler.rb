# encoding: utf-8
require 'guard'
require 'guard/guard'

module Guard
  class Bundler < Guard
    BUNDLER_ENV_VARS = %w(RUBYOPT BUNDLE_PATH BUNDLE_BIN_PATH BUNDLE_GEMFILE).freeze

    autoload :Notifier, 'guard/bundler/notifier'

    def initialize(watchers = [], options = {})
      super

      @original_env = {}
      options[:notify] = true if options[:notify].nil?
    end
 
    def start
      return refresh_bundle if bundle_need_refresh?
      true
    end

    def stop
      true
    end

    def reload
      refresh_bundle
    end

    def run_on_change(paths = [])
      return refresh_bundle if bundle_need_refresh?
      true
    end

    private

    def notify?
      !!options[:notify]
    end

    def bundle_need_refresh?
      with_clean_env do
        `bundle check`
      end
      $? == 0 ? false : true
    end

    def with_clean_env
      unset_bundler_env_vars
      ENV['BUNDLE_GEMFILE'] = File.join(Dir.pwd, "Gemfile")
      yield
    ensure
      restore_env
    end

    def unset_bundler_env_vars
      BUNDLER_ENV_VARS.each do |key|
        @original_env[key] = ENV[key]
        ENV[key] = nil
      end
    end

    def restore_env
      @original_env.each { |key, value| ENV[key] = value }
    end

    def refresh_bundle
      UI.info 'Refresh bundle', :reset => true
      start_at = Time.now
      result = ''
      with_clean_env do
        result = system('bundle install')
      end
      Notifier::notify(true, Time.now - start_at) if notify?
      result
    end

  end
end
