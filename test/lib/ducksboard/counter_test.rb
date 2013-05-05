require 'minitest_helper'

describe Ducksboard::Counter do

  describe '#delta=' do
    let(:counter) { Ducksboard::Counter.new(1) }

    before { counter.delta = 1.5 }

    it { counter.data[:delta].must_equal(1.5) }
  end
end
