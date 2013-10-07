# encoding: utf-8
module Guard
  class Bundler
    class Notifier

      def self.guard_message(result, duration)
        case result
        when 'up-to-date'
          "Bundle already up-to-date"
        when 'bundle_check_install'
          "Bundle installed using local gems"
        when true
          "Bundle has been installed\nin %.1f seconds." % [duration]
        else
          "Bundle can't be installed,\nplease check manually."
        end
      end

      # failed | success
      def self.guard_image(result)
        icon = if result
          :success
        else
          :failed
        end
      end

      def self.notify(result, duration)
        message = guard_message(result, duration)
        image   = guard_image(result)

        ::Guard::Notifier.notify(message, title: 'bundle install', image: image)
      end

    end
  end
end
