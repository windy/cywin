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
    end

    it '已经有结束的融资, 再创建没有问题' do
    end
  end

  describe "融资功能" do
    describe '启动融资' do
      it '启动融资成功' do
      end

      it '在融资阶段再次启动融资失败' do
      end
    end

    describe '投资' do
      it '单人投资' do
      end

      it '重复投资报错' do
      end

      it "二人投资" do
      end

      it "状态错误时投资" do
      end
    end

    describe "关闭融资" do
      it "正常关闭融资" do
      end

      it "无任何投资时关闭融资" do
      end

      it "无任何投资时重新打开融资" do
      end
    end
  end


  describe "融资权限测试" do
    pending
  end
end
