require 'minitest_helper'

describe Ducksboard::Slot do
  subject do
    Ducksboard::Slot
  end

  it "can initialize with an id" do
    slot = Ducksboard::Slot.new(123)
    slot.id.must_equal 123
  end

  describe "with a slot" do
    let(:slot) { Ducksboard::Slot.new(123) }

    it "sends data" do
      data = {:value => 123 }

      slot.expects(:post).with(data)
      slot.update(data)
    end

    it "ensures timestamp is unix timestamp" do
      time = Time.now
      unix_time = time.to_i

      slot.expects(:post).with({:timestamp => unix_time})
      slot.update({:timestamp => time})
    end

    it "can be destroyed" do
      slot.expects(:delete)
      slot.destroy
    end
  end

end
