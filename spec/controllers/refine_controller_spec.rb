require 'spec_helper'

describe RefineController do

  describe "GET 'index'" do
    it "returns http success" do
      project = create(:project)
      recommend = create(:recommend, project: project)
      get 'index'
      response.should be_success
    end
  end

end
