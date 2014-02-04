require 'spec_helper'

describe ProjectsSearcherController do

  describe "GET 'index'" do
    before do
      create(:project)
      create(:shenzhen_project)
      create(:shenzhen_project2)
    end
    it "all projects" do
      get 'index'
      assigns(:projects).size.should == 3
    end

    it "search name" do
      get 'index', search_name: 'name'
      assigns(:projects).size.should == 1
    end

    it "type" do
      pending
    end

    it "industry" do
      pending
    end

    it "district" do
      get 'index', district: '440300'
      assigns(:projects).size.should == 2
    end
  end

end
