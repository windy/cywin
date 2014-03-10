require 'spec_helper'

describe ActivitiesController do

  describe "GET 'show'" do
    login_user
    it "returns http success" do
      project = build(:project)
      project.add_owner(@user)
      project.save!

      get 'show'
      response.should be_success
    end
  end

end
