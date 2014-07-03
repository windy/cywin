class BankStatementsController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize! :update, Investor
    @bank_statement = current_user.investor.bank_statement
  end

  def create
    authorize! :update, Investor
    @bank_statement = current_user.investor.bank_statement || current_user.investor.build_bank_statement
    @bank_statement.image = params[:file]
    if @bank_statement.save
      render_success(nil, {
        id: @bank_statement.id,
        url: @bank_statement.image.url,
      })
    else
      render_fail( valid_on(@bank_statement, :image) )
    end
  end
end
