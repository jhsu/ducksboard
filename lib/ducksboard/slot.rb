module Ducksboard
  class Slot
    include Push
    include Pull

    attr_accessor :id

    # Initialize a new slot.
    #
    # id - A slot .
    def initialize(id)
      @id = id
    end
  end
end
