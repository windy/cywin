require 'spec_helper'

describe Admin::InvestorsController do

  login_admin
  describe "POST 'accept'" do
    describe "正确的审批" do
      it "刚提交即审批通过" do
        investor = create(:investor_applied)
        post 'accept', id: investor.id
        check_json(response.body, 'success', true)
        expect(investor.reload).to be_passed
        expect(investor.user).to be_has_role(:investor)
      end

      it "提交被拒绝, 重新提交审批通过" do
        investor = create(:investor_rejected)
        investor.submit!
        post 'accept', id: investor.id
        check_json(response.body, 'success', true)
        expect(investor.reload).to be_passed
      end
    end

    describe "错误的状态审批" do
      it "已审批过再次审批" do
        investor = create(:investor_passed)
        post 'accept', id: investor.id
        check_json(response.body, 'success', false)
        expect( assigns(:investor).errors[:status] ).not_to be_empty
        expect(investor.user).not_to be_has_role(:investor)
      end

      it "草稿状态无法审批" do
        investor = create(:investor)
        post 'accept', id: investor.id
        check_json(response.body, 'success', false)
        expect( assigns(:investor).errors[:status] ).not_to be_empty
      end

      it "已拒绝的无法审批" do
        investor = create(:investor_rejected)
        post 'accept', id: investor.id
        check_json(response.body, 'success', false)
        expect( assigns(:investor).errors[:status] ).not_to be_empty
      end
    end
  end

  describe "POST 'reject'" do

    describe "正确的状态" do
      it "提交申请被拒绝" do
        investor = create(:investor_applied)
        post 'reject', id: investor.id
        check_json(response.body, 'success', true)
        expect(investor.reload).to be_rejected
      end
    end

    describe "错误的状态" do
      pending '与申批上例类似'
    end
  end

end
