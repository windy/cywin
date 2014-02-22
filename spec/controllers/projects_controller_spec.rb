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
      assigns(:project).owner.should eq(@user)
    end
  end

  describe "stage1" do
    login_user
    before do
      @project = build(:project)
      @project.add_owner(@user)
      @project.save
    end

    it "get stage1" do
      Project.should_receive(:find).with("1").and_return(@project)
      get 'stage1', id: 1
      response.should render_template(:stage1)
    end

    describe "post stage1" do
      it "正确的参数" do
        Project.should_receive(:find).with("1").and_return(@project)
        post 'stage1', ActionController::Parameters.new({ id: 1, project: { owner: {avatar: nil}, member: attributes_for(:member) } })
        response.should redirect_to( stage2_project_path(1) )
        project = assigns(:project)
        expect(project.member( @user ).title).to eq( attributes_for(:member)[:title] )
      end

      it "正确的参数, 附带头像" do
        Project.should_receive(:find).with("1").and_return(@project)
        post 'stage1', ActionController::Parameters.new({ 
          id: 1,
          project: {
            owner: {
              avatar: fixture_file_upload( File.join(Rails.root, "spec/fixtures/logo.png"), 'image/png' )
            },
            member: attributes_for(:member)
          } 
        })
        response.should redirect_to( stage2_project_path(1) )
        project = assigns(:project)
        expect(project.member( @user ).title).to eq( attributes_for(:member)[:title] )
        expect(@user.reload.avatar_url).not_to be_nil

      end

      it "带邀请链接" do
        pending
      end

      it "post stage1 错误的上传头像" do
        pending
      end

      it " post stage1 没有上传头像" do
        pending
      end
    end
  end

  describe "stage2" do
    login_user
    before do
      @project = build(:project)
      @project.add_owner(@user)
      @project.save
    end
    it "get stage2" do
      Project.should_receive(:find).with("1").and_return(@project)
      get 'stage2', id: 1
      response.should render_template(:stage2)
    end

    it "post stage2" do
      Project.should_receive(:find).with("1").and_return(@project)
      post 'stage2', ActionController::Parameters.new({ project: { money_requires: attributes_for(:money_require), person_requires: attributes_for(:person_require) }, id: 1})
      response.should redirect_to( edit_project_path(@project.id) )
    end
  end

  describe "项目的权限控制测试" do
    describe "投资人, 领投人对项目的权限" do
      it "投资人对一般项目都有权限查看" do
        pending
      end

      it "投资人对要求领投人才能查到细节的权限无法查阅" do
        pending
      end
      
      it "领投人对有权限要求的项目可查阅" do
        pending
      end
    end

    describe "项目编辑与邀请成员的功能" do
      describe "编辑" do
        it "owner 可编辑项目所有功能" do
          pending
        end

        it "editor 可编辑项目所有功能" do
          pending
        end

        it "viewer 只能查阅项目" do
          pending
        end
      end
    end
  end

end
