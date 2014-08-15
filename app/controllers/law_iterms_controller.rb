class LawItermsController < ApplicationController

  before_action do
    @money_require = MoneyRequire.find(params[:money_require_id])
  end

  def index
    render json: @money_require.law_iterms.collect(&:id)
  end

  # 自定义条款
  def diy
    authorize! :update, @money_require
    @law_iterm = LawIterm.new( law_iterm_params )
    @law_iterm.project = @money_require.project
    @law_iterm.public = false
    if @law_iterm.save
      # render diy.json.jbuilder
    else
      render_fail(nil, @law_iterm)
    end
  end

  # 创建关联
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

  private
  def law_iterm_params
    params.permit(:title, :description)
  end

end
