module Ducksboard
  class Pin < Widget
    def valid?
      @data[:value].is_a?(Integer)
    end
  end
end
