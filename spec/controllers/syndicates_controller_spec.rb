require 'spec_helper'

describe SyndicatesController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "POST 'syndicate'" do
    login_user
    before do
      project = create(:project)
      project.money_requires << build(:money_require)
      project.save!
      @money_require = project.money_requires.first
    end
    it "success" do
      @user.investor = build(:investor)
      @user.save!
      @money_require.quickly_turn_on!(1)
      expect(@money_require.reload.progress).to eq(0)
      post 'create', ActionController::Parameters.new(investment:{ money_require_id: @money_require.id, money: 10 })
      response.should render_template("syndicates/invest")
      expect(@money_require.reload.progress).not_to eq(0)
    end

    it "没有申请投资人失败" do
      @money_require.quickly_turn_on!(1)
      expect(@money_require.reload.progress).to eq(0)
      post 'create', ActionController::Parameters.new(investment:{ money_require_id: @money_require.id, money: 10 })
      check_json(response.body, :success, false)
    end
    
    it "没有领投时失败" do
      @money_require.preheat!
      expect(@money_require.reload.progress).to eq(0)
      post 'create', ActionController::Parameters.new(investment:{ money_require_id: @money_require.id, money: 10 })
      check_json(response.body, :success, false)
    end
  end

  describe "权限控制" do
    pending
  end

end
