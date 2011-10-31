module Ducksboard
  class Counter < Widget
    def value=(number)
      @data ||= {}
      @data.merge!({:value => number})
    end
  end
end
