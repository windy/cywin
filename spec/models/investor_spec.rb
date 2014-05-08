require 'spec_helper'

describe Investor do
  describe "申请投资人测试" do
    it "create new" do
      expect { create(:investor) }.not_to raise_error
    end

    describe "正确的审核流程" do
      it "草稿下提交通过" do
        investor = create(:investor)
        expect(investor.status).to eq('drafted')
        investor.submit
        expect(investor.status).to eq('applied')
      end

      it "审核通过" do
        investor = create(:investor)
        investor.submit
        investor.pass
        expect(investor.status).to eq('passed')
      end

      it "审核不通过" do
        investor = create(:investor)
        investor.submit
        investor.reject
        expect(investor.status).to eq('rejected')
      end

      it "审核不通过重新提交" do
        investor = create(:investor)
        investor.submit
        investor.reject
        investor.submit
        expect(investor.status).to eq('applied')
      end
    end

    describe "不允许的审核流程" do
      it "未提交的无法审核" do
        investor = create(:investor)
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
