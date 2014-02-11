require "spec_helper"

describe InvestorsController do
  describe "routing" do

    it "routes to #index" do
      get("/investors").should route_to("investors#index")
    end

    it "routes to #new" do
      get("/investors/new").should route_to("investors#new")
    end

    it "routes to #show" do
      get("/investors/1").should route_to("investors#show", :id => "1")
    end

    it "routes to #edit" do
      get("/investors/1/edit").should route_to("investors#edit", :id => "1")
    end

    it "routes to #create" do
      post("/investors").should route_to("investors#create")
    end

    it "routes to #update" do
      put("/investors/1").should route_to("investors#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/investors/1").should route_to("investors#destroy", :id => "1")
    end

  end
end
