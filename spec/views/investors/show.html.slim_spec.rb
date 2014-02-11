require 'spec_helper'

describe "investors/show" do
  before(:each) do
    @investor = assign(:investor, stub_model(Investor))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
