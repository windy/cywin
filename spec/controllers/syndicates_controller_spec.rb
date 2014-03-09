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
      @money_require.start!
      expect(@money_require.reload.progress).to eq(0)
      post 'create', ActionController::Parameters.new(investment:{ money_require_id: @money_require.id, money: 10 })
      check_json(response.body, :success, true)
      expect(@money_require.reload.progress).not_to eq(0)
    end
  end

end
