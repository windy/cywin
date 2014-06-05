require 'spec_helper'

describe Investor do
  describe "申请投资人测试" do

    describe "正确的审核流程" do
      it "草稿下提交通过" do
        user = create_investor_user(:user, norole: true)
        investor = user.investor
        expect(investor.status).to eq('drafted')
        investor.submit
        expect(investor.status).to eq('applied')
      end

      it "审核通过" do
        user = create_investor_user(:user, norole: true)
        investor = user.investor
        investor.submit
        investor.pass
        expect(investor.status).to eq('passed')
      end

      it "审核不通过" do
        user = create_investor_user(:user, norole: true)
        investor = user.investor
        investor.submit
        investor.reject
        expect(investor.status).to eq('rejected')
      end

      it "审核不通过重新提交" do
        user = create_investor_user(:user, norole: true)
        investor = user.investor
        investor.submit
        investor.reject
        investor.submit
        expect(investor.status).to eq('applied')
      end

      it "审核通过带审计" do
        user = create_investor_user(:user, norole: true)
        investor = user.investor
        investor.submit
        investor.pass_with_audit('note')
        expect(investor.status).to eq('passed')
        expect(user).to be_has_role(:investor)
      end

      it "审核不通过带审计" do
        user = create_investor_user(:user, norole: true)
        investor = user.investor
        investor.submit
        investor.reject_with_audit('note')
        expect(investor.status).to eq('rejected')
        expect(user).not_to be_has_role(:investor)
      end
    end

    describe "不允许的审核流程" do
      it "未提交的无法审核" do
        user = create_investor_user(:user, norole: true)
        investor = user.investor
        expect(investor.pass).to be_false
      end
    end
  end

  describe "多次投资" do
    it "many investments" do
      investor = create_investor_user(:user)
      investor.investments.build( attributes_for(:investment) )
      investor.investments.build( attributes_for(:investment) )
      investor.save.should be_true
      investor.investments.size.should == 2
    end
  end
  
end
