class InvestmentObserver < ActiveRecord::Observer

  def after_create(investment)
    if investment.money_require_id.present?
      Event.create(
        user: investment.user,
        project: investment.money_require.project,
        action: Event::PROJECT_INVEST,
        data: {
          money: investment.money
        }
      )
    end
  end

  def after_update(investment)
    if investment.money_require_id.present?
      Event.create(
        user: investment.user,
        project: investment.money_require.project,
        action: Event::PROJECT_INVEST_ADD,
        data: {
          money: investment.money
        }
      )
    end
  end
end
