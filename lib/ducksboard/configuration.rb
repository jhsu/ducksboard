require 'yaml'
module Ducksboard
  class Configuration
    DEFAULT_RC_FILE = File.join(File.expand_path("~/"), ".ducksboardrc")

    def self.file 
      if File.exists? DEFAULT_RC_FILE
        DEFAULT_RC_FILE
      end
    end

    def self.api_key
      if file
        YAML.load_file(file)['api_key'].to_s
      elsif api_key = ENV['DUCKSBOARD_API_KEY']
        api_key
      end
    end

  end
end
