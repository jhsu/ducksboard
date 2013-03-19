module Ducksboard
  module Push
    include Request
    PUSH_URL = "https://push.ducksboard.com/values"

    # Update slot with data.
    #
    # data - A hash or array of hashes of data to send with the update:
    #   value - A new value for a slot.
    #   delta - A change in value for a slot.
    #   timestamp - A time or unix timestamp(optional).
    # 
    # Returns nothing.
    def update(data={})
      data[:timestamp] = time_to_unix(data[:timestamp]) if data[:timestamp]
      post(data)
    end

    # Deletes all data for a given data source.
    #
    # Returns nothing.
    def destroy
      delete
    end

    protected

    # Internal: Convert time to unix timestamp if needed.
    #
    # Returns a fixnum.
    def time_to_unix(time)
      if time.respond_to?(:to_i)
        time.to_i 
      else
        time
      end
    end

    # Internal: Sends http request.
    #
    # sending_data - A hash converted #to_json before sent (required).
    #
    # Returns nothing.
    def post(sending_data)
      self.class.post(
        "#{PUSH_URL}/#{id}",
        :basic_auth => auth,
        :body => sending_data.to_json
      )
    end

    # Internal: Send delete request.
    #
    # Returns nothing.
    def delete
      self.class.delete("#{PUSH_URL}/#{id}", :basic_auth => auth)
    end
  end
end
