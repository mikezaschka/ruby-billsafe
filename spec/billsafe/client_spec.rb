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

end
