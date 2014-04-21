require 'spec_helper'

describe ProjectsController do

  describe "POST create" do
    login_user
    it "create new" do
      post :create, ActionController::Parameters.new( attributes_for(:project) )
      assigns(:project).owner.should eq(@user)
    end
  end

  describe "GET show" do
    it "get json" do
      project = create(:project)
      get :show, id: project.id, format: :json
      expect(JSON.parse(response.body)['data']['name']).to eq(project.name)
    end
  end

  describe "PATCH update" do
    login_user
    it "success" do
      project = create(:project)
      project.add_owner( @user )
      project.save!
      patch :update, id: project.id, name: 'hello'
      check_json(response.body, :success, true)
    end
  end
end
