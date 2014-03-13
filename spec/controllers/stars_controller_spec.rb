require 'spec_helper'

describe StarsController do

  describe "关注" do
    login_user
    before do
      @project = create(:project)
    end
    it "添加关注" do
      post 'create', id: @project.id
      expect(Star.first.project_id).to eq(@project.id)
    end

    it "删除关注" do
      post 'create', id: @project.id

      expect { post 'destroy', id: @project.id }.to change{Star.all.size}.by(-1)
    end
  end

end
