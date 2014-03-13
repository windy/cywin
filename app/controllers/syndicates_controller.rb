class SyndicatesController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]

  def index
    @projects = Project.published
  end

  # 投资确认
  def create
    #TODO 投资人权限控制
    unless current_user.investor.present?
      render_fail("你没有权限投资本次融资, 请申请投资人资格后重试")
      return
    end
    money_require_id = params.require(:investment).permit(:money_require_id)[:money_require_id]
    @money_require = MoneyRequire.find(money_require_id)
    investment = Investment.new( investment_params )
    investment.investor_id = current_user.investor.id
    @money_require.investments << investment
    if @money_require.save
      render template: 'syndicates/invest', layout: false
    else
      render_fail(investment.errors.full_messages)
    end
  end

  private
  def investment_params
    params.require(:investment).permit(:money)
  end
end
