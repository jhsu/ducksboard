require 'json'
module Ducksboard
  class Widget
    include ::HTTParty
    base_uri "https://push.ducksboard.com/values"
    default_params basic_auth: {username: Configuration.api_key}

    attr_accessor :id, :data, :type

    def initialize(id, data={})
      @id = id
      @data = data
    end

    def update(data=nil)
      @data = data if data
      self.class.post('/' + id.to_s, body: @data.to_json)
    end
  end
end
