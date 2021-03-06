class Reminder
  attr_accessor :title, :subtitle, :content
  def initialize(args)
    self.title = args[:title].to_s
    self.subtitle = args[:subtitle].to_s
    self.content = args[:content].to_s
  end

  def display
    with_title = !title.empty? ? "\"#{title}\"" : "\"Tip\""
    with_subtitle = !subtitle.empty? ? "subtitle \"#{subtitle}\"" : ""
    applescript = "display notification \"#{content}\" with title #{with_title} #{with_subtitle}"
    cmd = "osascript -e '#{applescript}'"
    system cmd
  end

  def self.from_file(f)
    title, subtitle, content = File.read(f).split("\n")
    self.new :title=>title, 
              :subtitle=>subtitle,
              :content=>content
  end
end
