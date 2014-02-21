require 'spec_helper'

describe User do
  describe "star功能" do

    describe "add" do
      it "正常" do
        project = build(:project)
        user = create(:user)
        project.add_owner(user)
        project.save!

        expect {
          user.add_star(project)
        }.to change{ user.stars.size }.by(1)
      end

      it "错误的重复关注" do
        project = build(:project)
        user = create(:user)
        project.add_owner(user)
        project.save!
        user.add_star(project)

        expect {
          user.add_star(project)
        }.to change{ user.stars.size }.by(0)
      end
    end

    describe "remove" do
      it "已关注被删除" do
        project = build(:project)
        user = create(:user)
        project.add_owner(user)
        project.save!
        user.add_star(project)

        expect {
          user.remove_star(project)
        }.to change{ user.stars.size }.by(-1)
      end

      it "已被删除后再次删除" do
        project = build(:project)
        user = create(:user)
        project.add_owner(user)
        project.save!

        expect {
          user.remove_star(project)
        }.to change{ user.stars.size }.by(0)
      end
    end
  end

  describe "粉丝功能" do
    describe "add" do
      it "正常" do
        user = create(:user)
        zhang = create(:zhang)

        expect {
          zhang.add_fun(user)
        }.to change{ zhang.funs.size }.by(1)
      end

      it "已存在" do
        user = create(:user)
        zhang = create(:zhang)
        zhang.add_fun(user)

        expect {
          zhang.add_fun(user)
        }.to change{ zhang.funs.size }.by(0)
      end
    end
  end
end
