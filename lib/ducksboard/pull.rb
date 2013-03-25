module Ducksboard
  module Pull
    include ::HTTParty
    include Request
    PULL_URL = "https://pull.ducksboard.com/values"

    # Get the last :count values.
    #
    # options - A hash of options:
    #   count - A integer of the last :count values to fetch.
    #
    # Returns a hash response.
    def last(options={})
      get("last", options)
    end

    # Get data since timestamp.
    #
    # options - A hash of options:
    #   seconds - A start time in secods.
    #
    # Returns a hash response.
    def since(options={})
      get("since", options)
    end

    # Get data summarized by timespan.
    #
    # options - A hash of options:
    #   timespan - A string timespan.
    #   timezone - A string timezone (default: UTC).
    #
    # Returns a hash response.
    def timespan(options={})
      get("timespan", options)
    end

    protected

    # Internal: Get request for data.
    #
    # endpoint - string.
    def get(endpoint, params={})
      uri = Addressable::URI.new
      uri.query_values = params
      HTTParty.get("#{PULL_URL}/#{id}/#{endpoint}?#{uri.query}", :basic_auth => auth)
    end
  end
end
