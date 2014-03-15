class Admin::InvestorsController < Admin::ApplicationController
  def index
    @investor = Investor.all
  end

  def accept
  end

  def reject
  end
end
