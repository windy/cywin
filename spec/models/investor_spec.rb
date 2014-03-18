require 'spec_helper'

describe Investor do
  describe "申请投资人测试" do
    it "create new" do
      expect { create(:investor) }.not_to raise_error
    end

    it "草稿下提交通过" do
      investor = create(:investor)
      expect(investor.status).to eq('drafted')
      investor.submit 
      expect(investor.status).to eq('applied')
    end

    it "审核通过" do
      investor = create(:investor)
      investor.submit 
    end

    it "审核不通过" do
    end

    it "审核不通过重新提交" do
    end
  end

  describe "多次投资" do
    it "many investments" do
      investor = build(:investor)
      investor.investment.build( attributes_for(:investment) )
      investor.investment.build( attributes_for(:investment) )
      investor.save.should be_true
      investor.investment.size.should == 2
    end
  end
  
end
