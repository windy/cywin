require 'spec_helper'
describe InvestorsController do

  login_user
  describe "GET basic" do
    it "assigns a new investor as @investor" do

      expect(@user.investor).to be_nil 
      get :basic
      expect(@user.reload.investor).not_to be_new_record
    end

    it "GET basic without login" do
      sign_out :user
      get :basic
      response.should be_redirect
    end

    it "已经申请通过进行编辑" do
      investor = build(:investor)
      investor.user = @user
      investor.save!

      get :basic
      response.should be_success
      assigns(:investor).should eq(investor)
    end
  end

end
