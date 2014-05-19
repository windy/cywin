class SyndicatesController < ApplicationController
  before_action :authenticate_user!

  # 投资确认
  def create
    authorize! :create, Investment
    money_require_id = params[:money_require_id]
    @money_require = MoneyRequire.find(money_require_id)
    investment = Investment.new( money: params[:money] )
    investment.user = current_user
    investment.money_require = @money_require
    if investment.save
    else
      render_fail('投资失败', investment)
    end
  end
  
  # 追加投资
  def update
    @investment = Investment.find( params[:id] )
    already_money = @investment.money
    authorize! :update, @investment

    if @investment.update(money: params[:money])
      @money_require = @investment.money_require
      render :create
    else
      render_fail('追资失败', @investment)
    end
  end

end
