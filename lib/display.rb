module Reminder
  module Display
    def self.display(tip)
      case Reminder::Config.notify_with.downcase
      when "growl"
        display_with_growl tip
      when "notification center"
        display_with_notification_center tip
      end
    end

    def self.display_with_notification_center(tip)
      with_title = tip.title? ? "\"#{tip.title}\"" : "\"Tip\""
      with_subtitle = tip.subtitle? ? "subtitle \"#{tip.subtitle}\"" : ""
      applescript = "display notification \"#{tip.content}\" with title #{with_title} #{with_subtitle}"
      cmd = "osascript -e '#{applescript}'"
      system cmd
    end

    #http://growl.info/documentation/applescript-support.php
    def self.display_with_growl
      puts "Grrrr!"
      # tell application id "com.Growl.GrowlHelperApp"
      #
    end

    def register_growl

    end
  end
end
