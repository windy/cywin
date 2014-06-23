class InvestorsController < ApplicationController
  before_action :authenticate_user!

  def index
    @investors = Investor.passed.default_order.page(params[:page])
  end

  def search
    @investors = Investor.search do
      fulltext "*#{params[:q]}*"
      paginate page: params[:page], per_page: PersonRequire::PER_PAGE
      with(:status, 'passed')
    end.results
    render :index
  end

  def basic
    @investor = current_user.investor || current_user.build_investor
    if @investor.new_record?
      @investor.save(validate: false)
    end

    respond_to do |format|
      format.json { render 'basic' }
      format.html { render 'basic' }
    end
  end

  def idea
    authorize! :update, Investor
    @investor = current_user.investor
    @investidea = current_user.investor.investidea || current_user.investor.build_investidea
    if @investidea.new_record?
      @investidea.save(validate: false)
    end
  end

  def prove
    authorize! :update, Investor
    @investor = current_user.investor
  end

  def info
    authorize! :update, Investor
    @investor = current_user.investor
  end

  # 提交审核
  def submit
    authorize! :update, Investor
    @investor = current_user.investor
    if @investor.submit
      render_success
    else
      render_fail
    end
  end

  def create
    authorize! :update, Investor
    @investor = current_user.investor

    # 名字使用统一的用户名
    current_user.name = params[:name]
    unless current_user.save
      render_fail(nil, current_user)
      return
    end

    if @investor.update( investor_params )
      render_success
    else
      render_fail(nil, @investor)
    end
  end

  private
  def investor_params
    params.permit(:phone, :investor_type, :company, :title, :description )
  end

end
