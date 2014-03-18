class InvestorsController < ApplicationController
  before_action :set_investor, only: [:stage1, :stage2, :edit]
  before_action :authenticate_user!

  def new
    @investor = Investor.new
    @investor.investment.build
  end

  def stage1
    @investor.build_investidea
    if request.post?
      @investor.investidea = Investidea.new(investidea_params)
      if @investor.save
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
      if @investor.update( card_params )
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

  def edit
  end

  def create
    @investor = Investor.new( investor_params )
    @investor.user_id = current_user.id
    #TODO 支持多个项目
    @investor.investment.build( investment_params )
    if @investor.save
      redirect_to stage1_investor_path(@investor.id)
    else
      render :new
    end
  end

  private
    def set_investor
      @investor = Investor.find(params[:id])
    end

    def investor_params
      params.require(:investor).permit(:name, :phone, :investor_type, :company, :title, :description )
    end

    def investment_params
      params.require(:investor).require(:investment).permit(:name, :address, :description)
    end

    def investidea_params
      params.require(:investor).require(:investidea).permit(:coin_type, :min, :max, :industry, :give, :idea)
    end
    def card_params
      params.require(:investor).permit(:card)
    end
end
