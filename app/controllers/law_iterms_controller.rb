class LawItermsController < ApplicationController

  before_action do
    @money_require = MoneyRequire.find(params[:money_require_id])
  end

  def index
    render json: @money_require.law_iterms.collect(&:id)
  end

  def create
    authorize! :update, @money_require
    law_iterms = params[:ids].to_a.collect { |id| LawIterm.find(id) }
    @money_require.law_iterms = law_iterms
    if @money_require.save
      render_success
    else
      render_fail
    end
  end

end
