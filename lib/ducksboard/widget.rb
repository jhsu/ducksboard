require 'json'
module Ducksboard
  class Widget
    include ::HTTParty

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
      self.class.post("#{PUSH_URI}/#{@id.to_s}",
        :basic_auth => auth,
        :body => @data.to_json)
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

    def last_values(number_of_values=3)
      pull("last?count=#{number_of_values}")
    end

    def since(seconds_ago=3600)
      pull("since?seconds=#{seconds_ago.to_i}")
    end

    def timespan(timespan=:monthly, timezone="UTC")
      pull("timespan?timespan=#{timespan.to_s}&timezone=#{timezone}")
    end

    private

    PUSH_URI = "https://push.ducksboard.com/values"
    PULL_URI = "https://pull.ducksboard.com/values"

    def auth()
      {:username => ::Ducksboard.api_key, :password => "ducksboard-gem"} 
    end

    def pull(service_uri)
      response = self.class.get("#{PULL_URI}/#{@id.to_s}/#{service_uri}",
        :basic_auth => auth)

      if response.code.to_i == 200
        JSON.parse(response.body)
      else
        raise "Unexpected response code: #{response.code}; body: #{response.body}"
      end
    end
  end
end
