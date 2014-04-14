module Ducksboard
  class Box < Widget
    def valid?
      @data[:value].kind_of?(Numeric)
    end
  end
end

