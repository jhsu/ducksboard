module Ducksboard
  class Counter < Widget

    def delta=(delta)
      @data[:delta] = delta
    end
  end
end
