require 'spec_helper'

describe MoneyRequire do

  describe "创建一轮融资" do
    before do
      @user = create_investor_user
      @project = create_project_with_owner(@user)
    end

    it "正确的金额与时间" do
      @project.money_requires << build(:money_require)
      @project.save!
      @money_require = @project.money_requires.first

      expect(@money_require.status).to eq('ready')
    end

    it "正确的金融" do
      params = attributes_for(:money_require)
      params[:money] = 1000
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
      params[:share] = 99
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
      params[:deadline] = 20
      @project.money_requires << MoneyRequire.new(params)
      expect(@project.save).to be_false
    end

    it '已经有开启的融资, 再创建一个会失败' do
      params = attributes_for(:money_require)
      @project.money_requires << MoneyRequire.new(params)
      @project.save!
      
      # 启动第一个投资
      first = @project.money_requires.first
      first.preheat!

      second = MoneyRequire.new(params)
      second.project = @project
      expect(second.save).to be_false
      expect(second).to have(1).errors_on(:base)

    end

    it '已经有结束的融资, 再创建没有问题' do
      params = attributes_for(:money_require)
      @project.money_requires << MoneyRequire.new(params)
      
      # 启动第一个投资
      first = @project.money_requires.first
      first.leader = @user
      first.status = 'closed'
      first.save!

      second = MoneyRequire.new(params)
      second.project = @project
      expect(second.save).to be_true
    end
  end

  describe "融资功能" do
    before do
      #创建一轮融资
      @user = create_investor_user(:user)
      @project = create_project_with_owner(@user)
      params = attributes_for(:money_require)
      @project.money_requires << MoneyRequire.new(params)
      @project.save!

      @leader = @user
      
      @money_require = @project.money_requires.first
    end

    describe '启动融资' do
      it '启动融资成功' do
        expect(@money_require.status).to eq("ready")
        @money_require.preheat!
        expect(@money_require.status).to eq("leader_needed")
      end

      it '在融资阶段再次启动融资失败' do
        expect(@money_require.status).to eq("ready")
        @money_require.preheat!

        expect { @money_require.preheat! }.to raise_error
      end
    end

    describe '投资' do
      describe "领投功能" do
        describe "正确的" do
          it "找到正确的领投人" do
            @money_require.preheat!
            # find an investor
            expect( @money_require.add_leader_and_wait_confirm(@leader.id) ).to be_true
          end

          it "领投确认" do
            @money_require.preheat!
            @money_require.add_leader_and_wait_confirm(@leader.id)
            expect(@money_require.leader_confirm).to be_true
            expect(@money_require.status).to eq("opened")
          end
        end

        describe "错误的" do
          it "未领投无法投资" do
            @money_require.preheat!
            investment = Investment.new(money: attributes_for(:investment_for_money)[:money])
            investment.money_require = @money_require
            expect(investment.save).to be_false
            expect(investment).to have(1).errors_on(:base)
          end
        end
      end

      describe "领投完成后的投资" do
        before do
          @money_require.quickly_turn_on!(1)
        end
        it '单人投资' do
          investment = Investment.new(money: attributes_for(:investment_for_money)[:money])
          investment.money_require = @money_require
          expect(investment.save).to be_true
        end

        it '重复投资报错' do
          investment = Investment.new(money: attributes_for(:investment_for_money)[:money])
          investment.money_require = @money_require
          investment.save!

          investment = Investment.new(money: attributes_for(:investment_for_money)[:money])
          investment.money_require = @money_require
          expect(investment.save).to be_false
          expect(investment).to have(1).errors_on(:money_require_id)
        end

        it "二人投资" do
          user = @user

          zhang = create(:zhang)
          zhang.investor = build(:investor)
          zhang.save!
          
          first = Investment.new(money: attributes_for(:investment_for_money)[:money], user_id: user.id)
          first.money_require = @money_require
          expect(first.save).to be_true

          second = Investment.new(money: attributes_for(:investment_for_money)[:money], user_id: zhang.id)
          second.money_require = @money_require
          expect(second.save).to be_true
        end

        it "状态错误时投资" do
          investment = Investment.new(money: attributes_for(:investment_for_money)[:money])
          @money_require.investments << investment
          investment.money_require = @money_require
          expect(investment.save).to be_true

          @money_require.reload.close!
          investment.money_require = @money_require
          expect(investment.save).to be_false
        end

        it "投资金额错误" do
          [-1, 1.1, "hello"].each do |m|
            @money_require.reload
            investment = Investment.new(money: m)
            investment.money_require = @money_require
            expect(investment.save).to be_false
            expect(investment).to have(1).errors_on(:money)
          end
        end

        it "投资进度运算" do
          #设置 money 投资额
          @money_require.money = 1000
          @money_require.save!

          investment = Investment.new(money: 100)
          @money_require.investments << investment
          @money_require.save!

          expect(@money_require.progress).to eq(0.1)

          investment = Investment.new(money: 1000, user_id: 2)
          @money_require.reload
          @money_require.investments << investment
          @money_require.save!
          expect(@money_require.progress).to eq(1.1)
        end

        describe "关闭融资" do
          it "正常关闭融资" do
            investment = Investment.new(money: attributes_for(:investment_for_money)[:money])
            @money_require.investments << investment
            @money_require.save!
            expect(@money_require.close).to be_true
          end

          it "无任何投资时关闭融资" do
            expect(@money_require.close).to be_true
          end

        end

      end
    end

  end
end
