require 'minitest_helper'

describe Ducksboard do
  it "should get api key from env" do
    ENV['DUCKSBOARD_API_KEY'] = "123"
    Ducksboard.api_key.must_equal "123"
  end

  it "can set api key directly" do
    Ducksboard.api_key = "123"
    Ducksboard.api_key.must_equal "123"
  end
end
