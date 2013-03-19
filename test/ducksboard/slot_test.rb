require 'minitest_helper'

describe Ducksboard::Slot do
  let(:slot) { Ducksboard::Slot.new(123) }

  it "can initialize with an id" do
    slot.id.must_equal 123
  end


  describe "Push" do
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
  end # Push

  describe "Pull" do
    it "grabs last number of data" do
      stub_request(:get, /pull\.ducksboard\.com.*last/).to_return(
        :body => <<-RESPONSE,
{
  "count": 15,
  "data": [
            {
              "timestamp": 1332971928.20006,
              "value": 132.0
            }
          ]
}
        RESPONSE
        :headers => {'Content-Type' => 'application/json'})
      response = slot.last()
      response.must_be_kind_of Hash
    end

    it "grabs data since" do
      stub_request(:get, /pull\.ducksboard.com.*since/).to_return(
        :body => <<-RESPONSE,
{
  "count": 15,
  "data": [
            {
              "timestamp": 1332971928.20006,
              "value": 132.0
            }
          ]
}
        RESPONSE
        :headers => {'Content-Type' => 'application/json'})
      response = slot.since()
      response.must_be_kind_of Hash
    end

    it "grabs data by timespan" do
      skip "pending implementation"
    end

  end # Pull

end
