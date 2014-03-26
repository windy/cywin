require 'spec_helper'

describe Investidea do

  describe "正确的参数" do
    it "create new" do
      expect{ create(:investidea) }.to be_true
    end
  end

  describe "错误的参数" do
    it "最大投资额比最小的小" do
      investidea = build(:investidea)
      investidea.min = 100
      investidea.max = 1
      expect( investidea ).to have(1).errors_on(:max)

    end

    it "非整数" do
      investidea = build(:investidea)
      investidea.min = 100.0
      expect( investidea ).to have(1).errors_on(:min)
    end
  
  end

end
