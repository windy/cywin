require 'spec_helper'

describe Investor do
  it "create new" do
    expect { create(:investor) }.not_to raise_error
  end

  it "many investments" do
    investor = build(:investor)
    investor.investment.build( attributes_for(:investment) )
    investor.investment.build( attributes_for(:investment) )
    investor.save.should be_true
    investor.investment.size.should == 2
  end
end
