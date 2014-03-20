require 'spec_helper'

describe MoneyRequiresController do

  describe "POST 'CREATE'" do
    login_user
    before do
      @project = build(:project)
      @project.add_owner(@user)
      @project.save!
    end

    it "成功创建" do
      post 'create', ActionController::Parameters.new( project_id: @project.id, money_require: attributes_for(:money_require) )
      response.should be_success
      response.should render_template('syndicates/syndicate_info')
    end

    it "错误的deadline" do
      money_require_attr = attributes_for(:money_require, deadline: 7.days.ago.to_datetime )
      post 'create', ActionController::Parameters.new( project_id: @project.id, money_require: money_require_attr )
      response.should be_success
      check_json(response.body, :success, false)
    end
  end


end
