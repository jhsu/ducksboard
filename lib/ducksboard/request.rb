module Ducksboard
  module Request
    include ::HTTParty

    protected

    # Internal: Basic auth hash.
    #
    # Returns a hash.
    def auth
      {:username => Ducksboard.api_key, :password => "ducksboard-gem"}
    end
  end
end
