require 'spec_helper'

describe MembersController do

  describe "new" do
    login_user
    it "成功" do
      project = create(:project)
      get 'new', project_id: project.id
      response.should be_success
      response.should render_template('new')
    end
  end

  describe "autocomplete" do
    it '成功' do
      project = create(:project)
      get :autocomplete, project_id: project.id, search: 'hello'
      response.should be_success
    end
  end

  describe "create" do
    login_user
    describe "普通添加用户" do
      it "正常的情况" do
        project = create(:project)
        project.add_owner(@user)
        project.save!
        user = create(:zhang)
        
        post 'create', ActionController::Parameters.new(project_id: project.id, user_id: user.id, role: Member::FOUNDER)
        check_json(response.body, :success, true)
      end

      it "邀请的新用户" do
        project = create(:project)
        project.add_owner(@user)
        project.save!

        post 'invite', ActionController::Parameters.new(project_id: project.id, name: 'xxxx', email: 'xxxx@cywin.cn', role: Member::FOUNDER)
        check_json(response.body, :success, true)

        project.members.size.should == 2
        User.where(name: 'xxxx').first.invitation_token.should_not be_nil

      end

      it "邀请信息填写有误" do
        project = create(:project)
        project.add_owner(@user)
        project.save!

        post 'invite', ActionController::Parameters.new(project_id: project.id, name: 'xxxx', email: 'wrongemail', role: Member::FOUNDER)
        check_json(response.body, :success, false)
      end
    end

    describe "show" do
      it "在项目中" do
        project = create(:project)
        project.add_owner(@user)
        project.save!
        user = create(:zhang)
        project.add_user( user, role: Member::FOUNDER)
        project.save!

        get 'show', ActionController::Parameters.new(project_id: project.id, id: user.id)
        assigns(:member).should_not be_nil
      end
    end
  end

end
