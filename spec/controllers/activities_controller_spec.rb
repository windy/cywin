require 'spec_helper'

describe ActivitiesController do

  describe "GET 'show'" do
    login_user
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

end
