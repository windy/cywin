class Admin::InvestorsController < Admin::ApplicationController
  before_action :set_investor, only: [ :accept, :reject ]

  def index
    if params[:q] == 'applied'
      @investors = Investor.where(status: 'applied').default_order
    else
      @investors = Investor.where.not(status: 'drafted').default_order
    end
  end

  # POST: /admin/investor/1/accept
  def accept
    unless @investor.can_pass?
      # 仅仅为了取得 errors 信息
      @investor.pass
      render_fail(@investor.errors.full_messages.to_s)
      return
    end

    @investor.pass_with_audit( params[:note] )
    render_success
  end

  def reject
    unless @investor.can_reject?
      # 仅仅为了取得 errors 信息
      @investor.reject
      render_fail(@investor.errors.full_messages.to_s)
      return
    end

    @investor.reject_with_audit(params[:note])
    render_success
  end

  private
  def set_investor
    @investor = Investor.find(params[:id])
  end
end
