require 'json' 
require 'fileutils'

module Reminder
  module Config
    @@config = {}
    def self.load(config)
      @@config = JSON.parse(File.read(config))
    end

    def self.load_or_prompt_to_install(path, &block)
      path = File.expand_path path
      if File.exists?(path)
        self.load(path)
      elsif yield
        install(path)
      else
        "blow up"
      end
    end

    def self.install(path)
      config_dir = File.expand_path(File.dirname(path))
      FileUtils.mkdir_p(config_dir)
      default = File.join(File.dirname(__FILE__), "../support/default/*")
      Dir[default].each do |f|
        FileUtils.cp_r f, config_dir
      end
    end

    def self.method_missing(m, *args, &block)
      key = m.to_s.gsub("?", "")
      if @@config.has_key?(key) 
          @@config[key]
      else
        super
      end
    end
  end
end
