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
      stub_request(:get, /pull\.ducksboard.com.*timespan/).to_return(
        :body => <<-RESPONSE,
{
  "count": 9,
  "data": [
            {
              "timestamp": null,
              "period": null,
              "value": null
            },
            {
              "timestamp": 1355875200.0,
              "period": 3,
              "value": null
            },
            {
              "timestamp": 1355961600.0,
              "period": 4,
              "value": null
            },
            {
              "timestamp": 1356048000.0,
              "period": 5,
              "value": 1.0
            },
            {
              "timestamp": 1356134400.0,
              "period": 6,
              "value": 2.0
            },
            {
              "timestamp":  1356220800.0,
              "period": 7,
              "value": null
            },
            {
              "timestamp": 1356307200.0,
              "period": 1,
              "value": 3.0
            },
            {
              "timestamp": 1356393600.0,
              "period": 2,
              "value": null
            },
            {
              "timestamp": 1356480000.0,
              "period": 3,
              "value": null
            }
          ]
}
        RESPONSE
        :headers => {'Content-Type' => 'application/json'})

      response = slot.timespan(:timespan => "weekly", :timezone => "UTC")
      response.must_be_kind_of(Hash)
    end

  end # Pull

end
