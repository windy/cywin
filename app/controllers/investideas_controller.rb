class InvestideasController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize! :update, Investor
    @investor = current_user.investor
    @investidea = @investor.investidea || @investor.build_investidea
    if @investidea.new_record?
      @investidea.save(validate: false)
    end

    respond_to do |format|
      format.json
    end
  end

  def create
    authorize! :update, Investor
    @investor = current_user.investor
    @investidea = @investor.investidea

    if @investidea.update( investidea_params )
      render_success
    else
      render_fail(nil, @investidea)
    end
  end

  private
  def investidea_params
    params.permit(:coin_type, :min, :max, :industry, :give, :idea)
  end
end
