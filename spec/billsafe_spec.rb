require 'spec_helper'

describe Billsafe do

  it "should rock" do
    lambda do
      Billsafe.rock()
    end.should raise_error
  end

end