require 'yaml'
module Ducksboard
  class Configuration
    class << self
      attr_accessor :api_key
    end
    @api_key = ENV['DUCKSBOARD_API_KEY']
  end
end
