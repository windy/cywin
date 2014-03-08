class SyndicatesController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]

  def index
    @projects = Project.published
  end

  # 投资确认
  def create
    #TODO 投资人控制
    money_require_id = params.require(:investment).permit(:money_require_id)[:money_require_id]
    @money_require = MoneyRequire.find(money_require_id)
    investment = Investment.new( investment_params )
    @money_require.investments << investment
    if @money_require.save
      render_success
    else
      render_fail(investment.errors.full_messages)
    end
  end

  def investment_params
    params.require(:investment).permit(:money)
  end
end
