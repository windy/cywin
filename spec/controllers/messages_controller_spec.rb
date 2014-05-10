require 'spec_helper'

describe MessagesController do

  login_user
  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

end
