require 'spec_helper'
describe InvestorsController do

  login_user
  describe "GET new" do
    it "assigns a new investor as @investor" do
      get :new
      assigns(:investor).should be_a_new(Investor)
    end

    it "GET new without login" do
      sign_out :user
      get :new
      response.should be_redirect
    end

    it "已经申请通过进行编辑" do
      investor = build(:investor)
      investor.user = @user
      investor.save!

      get :new
      response.should be_success
      assigns(:investor).should eq(investor)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Investor" do
        expect {
          post :create, { investor: attributes_for(:investor).merge(investment: attributes_for(:investment)) }
        }.to change(Investor, :count).by(1)
      end

    end
  end

  describe "stage1" do
    it "get" do
      @user = create_investor_user(@user)
      investor = @user.investor
      get :stage1, id: investor.id
      response.should render_template(:stage1)
    end
  end

end
