class InvestorsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_investor, only: [:stage1, :stage2, :update]

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
    if current_user.investor.blank?
      redirect_to root_path
      return
    end
    @investor = current_user.investor
    @investidea = current_user.investor.investidea || current_user.investor.build_investidea
    if @investidea.new_record?
      @investidea.save(validate: false)
    end
  end

  def prove
    if current_user.investor.blank?
      redirect_to root_path
      return
    end
    @investor = current_user.investor
  end

  def info
  end

  def stage1
    @investor.investidea || @investor.build_investidea
    if request.post?
      @investor.investidea.assign_attributes(investidea_params)
      if @investor.investidea.save
        redirect_to stage2_investor_path(@investor.id)
      else
        render :stage1
        return
      end
    else
      render :stage1
      return
    end
  end

  def stage2
    if request.post?
      if @investor.update( card_params ) &&  @investor.validate_and_submit
        flash[:notice] = "创建申请成功"
        redirect_to root_path
      else
        render :stage2
        return
      end
    else
      render :stage2
      return
    end
  end

  def create
    @investor = current_user.investor
    if @investor.blank?
      render_fail
      return
    end

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
    def set_investor
      @investor = Investor.find(params[:id])
    end

    def investor_params
      params.permit(:phone, :investor_type, :company, :title, :description )
    end

    def investment_params
      params.require(:investor).require(:investment).permit(:name, :address, :description)
    end

    def investidea_params
      params.require(:investor).require(:investidea).permit(:coin_type, :min, :max, :industry, :give, :idea)
    end
    
    def card_params
      params.require(:investor).permit(:card) rescue {}
    end
end
