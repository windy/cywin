require 'spec_helper'

describe ProjectsController do

  describe "POST create" do
    login_user
    it "create new" do
      logo = create(:logo)
      post :create, ActionController::Parameters.new( attributes_for(:project).merge( { logo_id: logo.id, city: '深圳', industry: '互联网' }) )
      check_json(response.body, :success, true)
      assigns(:project).owner.should eq(@user)
    end
  end

  describe "GET show" do
    it "get json" do
      project = create(:project)
      get :show, id: project.id, format: :json
      expect(JSON.parse(response.body)['name']).to eq(project.name)
    end
  end

  describe "PATCH update" do
    login_user
    it "success" do
      logo = create(:logo)
      project = create_project_with_owner(@user)
      patch :update, id: project.id, name: 'hello', logo_id: logo.id, city: '深圳', industry: '互联网'
      check_json(response.body, :success, true)
    end
  end
end
