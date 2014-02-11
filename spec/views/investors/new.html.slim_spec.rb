require 'spec_helper'

describe "investors/new" do
  before(:each) do
    assign(:investor, stub_model(Investor).as_new_record)
  end

  it "renders new investor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", investors_path, "post" do
    end
  end
end
