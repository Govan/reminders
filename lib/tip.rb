module Reminder
  class Tip
    attr_accessor :title, :subtitle, :content
    def initialize(args)
      self.title = args[:title].to_s
      self.subtitle = args[:subtitle].to_s
      self.content = args[:content].to_s
    end

    def display
      case Reminder::Config.notify_with.downcase
      when "growl"
        display_with_growl
      when "notification center"
        display_with_notification_center
      end
    end

    def self.from_file(f)
      title, subtitle, content = File.read(f).split("\n")
      self.new :title=>title, 
        :subtitle=>subtitle,
        :content=>content
    end

    def self.random
      tip_root = File.join File.expand_path(Reminder::Config.tip_directory), "/**/*.txt"
      all_tips = Dir[tip_root]
      from_file(all_tips.shuffle.first)
    end

    private
    def display_with_notification_center
      with_title = !title.empty? ? "\"#{title}\"" : "\"Tip\""
      with_subtitle = !subtitle.empty? ? "subtitle \"#{subtitle}\"" : ""
      applescript = "display notification \"#{content}\" with title #{with_title} #{with_subtitle}"
      cmd = "osascript -e '#{applescript}'"
      system cmd
    end

    def display_with_growl
      puts "Grrrr!"
    end
  end
end
