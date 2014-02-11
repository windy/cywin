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
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Investor" do
        expect {
          post :create, { investor: attributes_for(:investor).merge(investment: attributes_for(:investment)) }
        }.to change(Investor, :count).by(1)
      end

      it "assigns a newly created investor as @investor" do
        pending
      end

      it "redirects to the created investor" do
        pending
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved investor as @investor" do
        pending
      end

      it "re-renders the 'new' template" do
        pending
      end
    end
  end

end
