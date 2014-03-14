module Reminder
  class Tip
    attr_accessor :title, :subtitle, :content
    def initialize(args)
      self.title = args[:title].to_s
      self.subtitle = args[:subtitle].to_s
      self.content = args[:content].to_s
    end

    def title?    
      !title.empty?
    end

    def subtitle?
      !subtitle.empty?
    end

    def content?
      !content.empty?
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
  end
end
