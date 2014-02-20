require 'spec_helper'

describe Project do
  it "logo should be presence" do
    expect { create(:project) }.not_to raise_error
  end

  it "logo_cache" do
    project = build(:project)
    project.where3 = ""
    expect(project.save).to be_false
    project.logo = nil
    project.where3 = "110011"
    expect(project.save).to be_true
  end

  describe "project user" do
    it "#add_owner #owner #member" do
      project = build(:project)
      owner = create(:user)
      project.add_owner(owner)
      expect(project.save).to be_true
      expect(project.owner).to eq(owner)
      expect(project.member(owner).user_id).to eq(owner.id)
    end
    
    it "users.size, project.size" do
      project = build(:project)
      owner = create(:user)
      project.add_owner(owner)
      project.save
      expect(owner.projects.size).to eq(1)
      expect(project.users.size).to eq(1)
    end
  end
end
