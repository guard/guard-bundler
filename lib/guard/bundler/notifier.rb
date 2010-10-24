# encoding: utf-8
module Guard
  class Bundler
    class Notifier

      def self.guard_message(result, duration)
        message = ''
        if result
          message << "Bundle has been updated\nin %.1f seconds." % [duration]
        else
          message << 'Bundle can\t be updated,\nplease check manually.'
        end
        message
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

        ::Guard::Notifier.notify(message, :title => 'Bundle update', :image => image)
      end

    end
  end
end