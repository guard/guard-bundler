# encoding: utf-8
require 'guard'
require 'guard/guard'

module Guard
  class Bundler < Guard

    autoload :Notifier, 'guard/bundler/notifier'

    def initialize(watchers = [], options = {})
      super

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
      `bundle check`
      $? == 0 ? false : true
    end

    def refresh_bundle
      UI.info 'Refresh bundle', :reset => true
      start_at = Time.now
      result = system('bundle install')
      Notifier::notify(true, Time.now - start_at) if notify?
      result
    end

  end
end
