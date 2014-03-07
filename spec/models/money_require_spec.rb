require 'spec_helper'

describe MoneyRequire do

  describe "创建一轮融资" do
    before do
      @project = create(:project)
    end

    it "正确的金额与时间" do
      @project.money_requires << build(:money_require)
      @project.save!
      @money_require = @project.money_requires.first

      expect(@money_require.status).to eq('ready')
    end

    it "正确的金融" do
      params = attributes_for(:money_require)
      params[:money] = 1
      @project.money_requires << MoneyRequire.new(params)
      expect(@project.save).to be_true
    end

    it '错误的金融' do
      params = attributes_for(:money_require)
      params[:money] = -1
      @project.money_requires << MoneyRequire.new(params)
      expect(@project.save).to be_false
      params[:money] = "xx"
      @project.money_requires << MoneyRequire.new(params)
      expect(@project.save).to be_false
    end

    it "正确的百分比" do
      params = attributes_for(:money_require)
      params[:share] = 1
      @project.money_requires << MoneyRequire.new(params)
      expect(@project.save).to be_true

    end

    it "正确的百分比最大值" do
      params = attributes_for(:money_require)
      params[:share] = 100
      @project.money_requires << MoneyRequire.new(params)
      expect(@project.save).to be_true
    end

    it "错误的百分比" do
      params = attributes_for(:money_require)
      params[:share] = -1
      @project.money_requires << MoneyRequire.new(params)
      expect(@project.save).to be_false
      
      params = attributes_for(:money_require)
      params[:share] = 101
      @project.money_requires << MoneyRequire.new(params)
      expect(@project.save).to be_false
    end

    it "正确的时间" do
      params = attributes_for(:money_require)
      @project.money_requires << MoneyRequire.new(params)
      expect(@project.save).to be_true
    end

    it '错误的时间' do
      params = attributes_for(:money_require)
      params[:deadline] = 7.days.ago.to_datetime
      @project.money_requires << MoneyRequire.new(params)
      expect(@project.save).to be_false
    end

    it '已经有开启的融资, 再创建一个会失败' do
      params = attributes_for(:money_require)
      @project.money_requires << MoneyRequire.new(params)
      @project.save!
      
      # 启动第一个投资
      first = @project.money_requires.first
      first.start!

      second = MoneyRequire.new(params)
      @project.money_requires << second
      expect(@project.save).to be_false

    end

    it '已经有结束的融资, 再创建没有问题' do
      params = attributes_for(:money_require)
      @project.money_requires << MoneyRequire.new(params)
      @project.save!
      
      # 启动第一个投资
      first = @project.money_requires.first
      first.start!
      first.close!

      second = MoneyRequire.new(params)
      @project.money_requires << second
      expect(@project.save).to be_true
    end
  end

  describe "融资功能" do
    before do
      #创建一轮融资
      @project = create(:project)
      params = attributes_for(:money_require)
      @project.money_requires << MoneyRequire.new(params)
      @project.save!
      @money_require = @project.money_requires.first
    end
    describe '启动融资' do
      it '启动融资成功' do
        expect(@money_require.status).to eq("ready")
        @money_require.start!
        expect(@money_require.status).to eq("open")
      end

      it '在融资阶段再次启动融资失败' do
        expect(@money_require.status).to eq("ready")
        @money_require.start!

        expect { @money_require.start! }.to raise_error
      end
    end

    describe '投资' do
      it '单人投资' do
        @money_require.start!
        investment = Investment.new(money: attributes_for(:investment_for_money)[:money])
        @money_require.investments << investment
        expect(@money_require.save).to be_true
      end

      it '重复投资报错' do
        @money_require.start!
        investment = Investment.new(money: attributes_for(:investment_for_money)[:money])
        @money_require.investments << investment
        @money_require.save!

        investment = Investment.new(money: attributes_for(:investment_for_money)[:money])
        @money_require.investments << investment
        expect(@money_require.save).to be_false
      end

      it "二人投资" do
        @money_require.start!
        user = create(:user)
        user.investor = build(:investor)
        user.save!

        zhang = create(:zhang)
        zhang.investor = build(:investor)
        zhang.save!
        
        first = Investment.new(money: attributes_for(:investment_for_money)[:money], investor_id: user.id)
        @money_require.investments << first
        expect(@money_require.save).to be_true

        second = Investment.new(money: attributes_for(:investment_for_money)[:money], investor_id: zhang.id)
        @money_require.investments << second
        expect(@money_require.save).to be_true
      end

      it "状态错误时投资" do
        investment = Investment.new(money: attributes_for(:investment_for_money)[:money])
        @money_require.investments << investment
        expect(@money_require.save).to be_false

        @money_require.reload.start!
        expect(@money_require.save).to be_true

        @money_require.close!
        @money_require.investments << investment
        expect(@money_require.save).to be_false
      end

      it "投资金额错误" do
        @money_require.reload.start!
        [-1, 1.1, "hello"].each do |m|
          @money_require.reload
          investment = Investment.new(money: m)
          @money_require.investments << investment
          expect(@money_require.save).to be_false
        end
      end

      it "投资进度运算" do
        #设置 money 投资额
        @money_require.money = 100
        @money_require.save!
        @money_require.start!

        investment = Investment.new(money: 10)
        @money_require.investments << investment
        @money_require.save!

        expect(@money_require.progress).to eq(0.1)

        investment = Investment.new(money: 100, investor_id: 2)
        @money_require.reload
        @money_require.investments << investment
        @money_require.save!
        expect(@money_require.progress).to eq(1.1)
      end
    end

    describe "关闭融资" do
      it "正常关闭融资" do
        @money_require.start!
        investment = Investment.new(money: attributes_for(:investment_for_money)[:money])
        @money_require.investments << investment
        @money_require.save!
        expect(@money_require.close).to be_true
      end

      it "无任何投资时关闭融资" do
        @money_require.start!
        expect(@money_require.close).to be_true
      end

      #TODO 暂不支持
      it "无任何投资时重新打开融资" do
        pending
      end
    end
  end


  describe "融资权限测试" do
    pending
  end
end
