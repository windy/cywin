class InvestorsController < ApplicationController
  before_action :set_investor, only: [:stage1, :stage2, :show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @investors = Investor.all
  end

  def show
  end

  def new
    @investor = Investor.new
    @investor.investment.build
  end

  def stage1
    @investor.build_investidea
    if request.post?

    else
      render :stage1
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

  def update
  end

  def destroy
  end

  private
    def set_investor
      @investor = Investor.find(params[:id])
    end

    def investor_params
      params.require(:investor).permit(:name, :phone, :type, :company, :title, :description )
    end

    def investment_params
      params.require(:investor).require(:investment).permit(:name, :address, :description)
    end
end
