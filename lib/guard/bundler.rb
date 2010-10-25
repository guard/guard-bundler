# encoding: utf-8
require 'guard'
require 'guard/guard'

module Guard
  class Bundler < Guard

    autoload :Notifier, 'guard/bundler/notifier'

    def initialize(watchers = [], options = {})
      super

      @notify = options[:notify].nil? ? true : options[:notify]
    end
 
    def start
      return refresh_bundle if bundle_need_refresh?
      true
    end

    def reload
      refresh_bundle
    end

    def run_on_change(paths = [])
      return refresh_bundle if bundle_need_refresh?
      true
    end

    def notify?
      !!@notify
    end

    private

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
