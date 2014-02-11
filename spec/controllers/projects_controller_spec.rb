require 'spec_helper'

describe ProjectsController do

  describe "index" do
    before do
      create(:project)
      create(:shenzhen_project)
      create(:shenzhen_project2)
    end
    it "all" do
      get 'index'
      assigns(:projects).size.should == 3
    end

    it "industry" do
      pending
    end

    it "district" do
      pending
    end
    
    it "name" do
      pending
    end

    it "type" do
      pending
    end
  end

  describe "create" do
    login_user
    it "get new" do
      post :new
      response.should be_success
    end

    it "create new" do
      post :create, ActionController::Parameters.new(project: attributes_for(:project).merge(contact_attributes: attributes_for(:contact)) )
      response.should redirect_to( stage1_project_path(1) )
    end
  end

  describe "stage1" do
    login_user
    it "get stage1" do
      project = build(:project)
      Project.should_receive(:find).with("1").and_return(project)
      get 'stage1', id: 1
      response.should render_template(:stage1)
    end
    it "post stage1" do
      project = build(:project)
      Project.should_receive(:find).with("1").and_return(project)
      post 'stage1', ActionController::Parameters.new({ id: 1, project: { members: attributes_for(:member) } })
      response.should redirect_to( stage2_project_path(1) )
    end
  end

  describe "stage2" do
    login_user
    it "get stage2" do
      project = build(:project)
      Project.should_receive(:find).with("1").and_return(project)
      get 'stage2', id: 1
      response.should render_template(:stage2)
    end

    it "post stage2" do
      project = build(:project)
      Project.should_receive(:find).with("1").and_return(project)
      post 'stage2', ActionController::Parameters.new({ project: { money_requires: attributes_for(:money_require), person_requires: attributes_for(:person_require) }, id: 1})
      response.should redirect_to('/')
    end
  end

end
