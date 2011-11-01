module Ducksboard
  class Graph < Widget
    def valid?
      @data[:timestamp] && @data[:value]
    end
  end
end
