require 'spec_helper'

describe MoneyRequiresController do

  login_user
  before do
    @user = create_investor_user(@user)
    @leader = @user
    @project = create_project_with_owner(@user)
  end

  describe "创建融资功能" do
    it "成功创建" do
      post 'create', ActionController::Parameters.new( attributes_for(:money_require).merge(project_id: @project.id) )
      response.should be_success
      check_json(response.body, :success, true)
    end

    it "错误的deadline" do
      money_require_attr = attributes_for(:money_require, deadline: -10)
      post 'create', ActionController::Parameters.new( money_require_attr.merge(project_id: @project.id) )
      response.should be_success
      check_json(response.body, :success, false)
    end
  end

  describe "更新融资功能" do
    it "普通状态可以更新" do
      @money_require = create(:money_require, project: @project)
      @money_require.preheat!
      post 'update', ActionController::Parameters.new( money: 10000, id: @money_require.id)
      check_json(response.body, :success, true)
    end

    it "已经融资的无法更新" do
      @money_require = create(:money_require, project: @project)
      @money_require.quickly_turn_on!(1)
      post 'update', ActionController::Parameters.new( money: 10000, id: @money_require.id)
      expect(response).to be_redirect
    end
  end

  describe "添加领投人" do
    before do
      @money_require = build(:money_require)
      @money_require.project = @project
      @money_require.save!
      @money_require.preheat!
    end

    describe "正确添加" do
      it "成功" do
        post 'add_leader', ActionController::Parameters.new( leader_id: @leader.id, id: @money_require.id, format: 'json' )
        expect( assigns(:money_require).status ).to eq('leader_need_confirmed')
      end
    end

    describe "错误添加" do
      it "leader_id 未传入" do
        post 'add_leader', ActionController::Parameters.new( id: @money_require.id, money_require: { leader_id: nil} )
        check_json(response.body, :success, false)
        expect( assigns(:money_require).errors[:leader_id] ).not_to be_empty
      end

      it "money_require 状态不对" do
        @money_require.quickly_turn_on!(1)
        post 'add_leader', ActionController::Parameters.new( id: @money_require.id, money_require: { leader_id: 1 })
        expect( response ).to be_redirect
      end
    end
  end

  describe "投资人确认功能" do
    before do
      @money_require = build(:money_require)
      @money_require.project = @project
      @money_require.save!
      @money_require.preheat!
      @money_require.add_leader_and_wait_confirm(@user.id)
    end

    it "正确确认" do
      xhr :post, 'leader_confirm', ActionController::Parameters.new( id: @money_require.id, money: 1000 )
      check_json(response.body, :success, true)
    end

    it "不是本人" do
      @money_require.leader_id = 10
      @money_require.save!
      post 'leader_confirm', ActionController::Parameters.new( id: @money_require.id )
      expect(response).to be_redirect
    end

    it "状态不正确" do
      # 调整为打开中
      @money_require.status = 'opened'
      @money_require.save!

      post 'leader_confirm', ActionController::Parameters.new( id: @money_require.id )
      check_json(response.body, :success, false)
    end
  end


end
