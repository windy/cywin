class Admin::InvestorsController < Admin::ApplicationController
  before_action :set_investor, only: [ :accept, :reject ]

  def index
    @investors = Investor.where(status: 'applied')
  end

  # POST: /admin/investor/1/accept
  def accept
    unless @investor.can_pass?
      # 仅仅为了取得 errors 信息
      @investor.pass
      render_fail(@investor.errors.full_messages.to_s)
      return
    end

    audit_params = params.permit(:note)
    investor_audit = InvestorAudit.new( audit_params )
    investor_audit.status = InvestorAudit::PASSED
    investor_audit.investor = @investor

    if investor_audit.save
      @investor.pass!
      @investor.user.add_role(:investor)
      render_success("审批通过")
    else
      render_fail(investor_audit.errors.full_messages.to_s)
    end
  end

  def reject
    unless @investor.can_reject?
      # 仅仅为了取得 errors 信息
      @investor.reject
      render_fail(@investor.errors.full_messages.to_s)
      return
    end

    audit_params = params.permit(:note)
    investor_audit = InvestorAudit.new( audit_params )
    investor_audit.status = InvestorAudit::REJECTED
    investor_audit.investor = @investor

    if investor_audit.save
      @investor.reject!
      @investor.user.remove_role(:investor)
      render_success("审核已拒绝")
    else
      render_fail(investor_audit.errors.full_messages.to_s)
    end
  end

  private
  def set_investor
    @investor = Investor.find(params[:id])
  end
end
