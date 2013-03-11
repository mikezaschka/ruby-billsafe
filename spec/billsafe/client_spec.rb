require "spec_helper"
require "request_spec_helper"

describe Billsafe::Client do
  include RequestSpecHelper

  let(:valid_attributes) do
    { merchant_id: "meid", merchant_license: "meli", application_signature: "appsig", application_version: "appve" }
  end

  let (:client) do
    Billsafe::Client.new(valid_attributes)
  end

  describe "#initialize" do
    it "initializes all attributes correctly" do
      client.merchant_id.should eql("meid")
      client.merchant_license.should eql("meli")
      client.application_signature.should eql("appsig")
      client.application_version.should eql("appve")
    end
  end

  describe "sending requests" do
    it "should handle valid requests" do
      stub_ok_request "yxz"
      result = client.call("PrepareOrder", :Order_currencyCode => "EUR")
      result['token'].should eql "yxz"
    end

    it "should throw errors with invalid requests" do
      stub_error_request
      expect { client.call("PrepareOrder", :Order_currencyCode => "EUR") }.to raise_error Billsafe::APIError
    end

  end

end
