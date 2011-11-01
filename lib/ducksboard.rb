require 'httparty'

module Ducksboard
  class << self ; attr_accessor :api_key end
  @api_key = ENV['DUCKSBOARD_API_KEY']
end

require 'ducksboard/widget'
require 'ducksboard/counter'
require 'ducksboard/image'
