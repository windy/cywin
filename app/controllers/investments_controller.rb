class InvestmentsController < ApplicationController

  def index
    if current_user.investor
      @investments = current_user.investor.investments.selfcreate
    else
      @investments = [] 
    end

    respond_to do
      format.json { render 'index' }
    end
  end

  def create
  end
end
