require 'spec_helper'

describe "investors/index" do
  before(:each) do
    assign(:investors, [
      stub_model(Investor),
      stub_model(Investor)
    ])
  end

  it "renders a list of investors" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
