require 'spec_helper'

describe InvestideasController do

  login_user
  describe "GET index" do

    it "get index with json" do
      create(:investor, user: @user)
      xhr :get, :index
      expect(response).to be_success
    end

    it "get index with no investor" do
      xhr :get, :index
      expect(response).to be_redirect
    end

  end

end
