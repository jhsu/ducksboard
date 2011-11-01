require 'json'
module Ducksboard
  class Widget
    include ::HTTParty
    base_uri "https://push.ducksboard.com/values"
    basic_auth Ducksboard.api_key, 'ducksboard-gem'

    attr_accessor :id, :data, :type

    def initialize(id, data={})
      @id = id
      @data = data
    end

    def value
      @data[:value]
    end

    def value=(val)
      @data[:value] = val
    end

    def timestamp
      @data[:timestamp]
    end

    def timestamp=(time)
      @data[:timestamp] = time
    end

    def update(data=nil)
      @data = data if data
      self.class.post('/' + id.to_s, :body => @data.to_json)
    end

    def save
      if valid?
        update.code.to_i == 200
      else
        raise "Invalid Data: #{@data.inspect}"
      end
    end

    def valid?
      true
    end
  end
end
