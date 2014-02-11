require 'spec_helper'

describe "investors/edit" do
  before(:each) do
    @investor = assign(:investor, stub_model(Investor))
  end

  it "renders the edit investor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", investor_path(@investor), "post" do
    end
  end
end
