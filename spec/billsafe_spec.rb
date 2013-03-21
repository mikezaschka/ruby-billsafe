require 'spec_helper'

describe Billsafe do
  
  let(:deflattened_hash) do
    {
      "items" => {
        "0" => "ruby",
        "1" => "bi",
        "nested" => {
          "0" => "ruby"
        }
      },
      "status" => "OK"
    }
  end
  
  let(:flattened_hash) do
    { 
      "items_0" => "ruby", 
      "items_1" => "bi", 
      "items_nested_0"=>"ruby",
      "status" => "OK"
    }
  end
  
  it "should flatten params" do
    Billsafe.send(:flatten_params, deflattened_hash).should eql(flattened_hash)
  end

  it "should deflatten params" do
    Billsafe.send(:deflatten_params, flattened_hash).should eql(deflattened_hash)
  end

end