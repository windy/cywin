class InvestmentsController < ApplicationController

  before_action :authenticate_user!

  def index
    if current_user.investor
      @investments = current_user.investments.selfcreate
    else
      @investments = [] 
    end

    respond_to do |format|
      format.json { render 'index' }
    end
  end

  def create
    @investment = Investment.new investment_params.merge(user: current_user)
    if @investment.save
      render_success
    else
      render_fail(nil, @investment)
    end
  end

  def investment_params
    params.permit(:name, :address, :description)
  end
end
