require 'spec_helper'

describe AboutController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'partner'" do
    it "returns http success" do
      get 'partner'
      response.should be_success
    end
  end

  describe "GET 'service'" do
    it "returns http success" do
      get 'service'
      response.should be_success
    end
  end

  describe "GET 'law'" do
    it "returns http success" do
      get 'law'
      response.should be_success
    end
  end

  describe "GET 'job'" do
    it "returns http success" do
      get 'job'
      response.should be_success
    end
  end

end
