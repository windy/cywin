class InvestorsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @investor_types = Investor::INVESTOR_TYPES
    @investors = Investor.passed.default_order.page(params[:page])
  end

  def autocomplete
    if params[:search].blank?
      @users = []
    else
      if params[:search].include?("@")
        @users = User.joins(:roles).where('roles.name' => :investor).where(email: params[:search])
      else
        @users = User.joins(:roles).where('roles.name' => :investor).where('users.name like ?', "%#{params[:search]}%").limit(5)
      end
    end

    respond_to do |format|
      format.json
    end
  end

  def search
    @investor_types = Investor::INVESTOR_TYPES
    @investors = Investor.search do
      fulltext "*#{params[:q]}*"
      paginate page: params[:page], per_page: PersonRequire::PER_PAGE
      with(:status, params[:investor_type]) if params[:investor_type].present?
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
    @investor_audits = @investor.investor_audits.default_order
  end

  # 提交审核
  def submit
    authorize! :update, Investor
    @investor = current_user.investor
    if @investor.submit_with_audit
      render_success
    else
      render_fail
    end
  end

  def show
    @investor = Investor.find(params[:id])
    @user = @investor.user
    @investments = @user.investments.selfcreate
    @investidea = @investor.investidea
  end

  def create
    authorize! :update, Investor
    @investor = current_user.investor

    # 名字使用统一的用户名
    current_user.name = params[:name]
    current_user.description = params[:description]
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
    params.permit(:phone, :investor_type, :company, :title)
  end

end
