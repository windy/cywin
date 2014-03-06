require 'spec_helper'

describe UsersController do

  describe "autocomplete" do
    login_user
    it "search 正确" do
      create(:zhang)
      get 'autocomplete', search: "t"
      response.should be_success
      JSON.parse(response.body)['data'].size.should == 1
      JSON.parse(response.body)['data'][0]['name'] == 'tester'
    end

    it "search 值为空" do
      get 'autocomplete'
      response.should be_success
      JSON.parse(response.body)['success'].should == false
    end
  end

end
