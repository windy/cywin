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
    puts project.logo_cache
  end

  it "members need" do
    pending
  end
end
