require 'spec_helper'

describe Project do
  it "简单创建可以成功" do
    expect { create(:project) }.not_to raise_error
  end

  it "published default is false" do
    project = create(:project)
    expect(project.published).to be_false
  end

  describe "project user" do
    it "#add_owner #owner #member" do
      project = build(:project)
      owner = create(:user)
      project.add_owner(owner)
      expect(project.save).to be_true
      expect(project.owner).to eq(owner)
      expect(project.member(owner).user_id).to eq(owner.id)
      expect(project.member(owner).priv).to eq('owner')
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

  describe "#investor_users" do
    before do
      @owner = create_investor_user(:user)
      @project = create_project_with_owner(@owner)
    end

    it "成功" do
      # 启动融资
      money_require = build(:money_require)
      @project.money_requires << money_require
      @project.save!
      money_require.quickly_turn_on!(@owner.id)

      investment = build(:investment_for_money)
      investment.user = @owner
      investment.money_require = money_require
      investment.save!

      expect(@project.investor_users.first.id).to eq( @owner.id )
    end

  end

  describe "#star_users" do
    it "success" do
      @project = create(:project)
      @user = create(:user)
      @user.add_star(@project)
      expect(@project.star_users.first.id).to eq(@user.id)
    end
  end
end
