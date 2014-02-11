class InvestorsController < ApplicationController
  before_action :set_investor, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /investors
  def index
    @investors = Investor.all
  end

  # GET /investors/1
  def show
  end

  # GET /investors/new
  def new
    @investor = Investor.new
    @investor.investment.build
  end

  # GET /investors/1/edit
  def edit
  end

  # POST /investors
  # POST /investors.json
  def create
    @investor = Investor.new( investor_params )
    @investor.user_id = current_user.id
    #TODO 支持多个项目
    @investor.investment.build( investment_params )
    if @investor.save
      redirect_to :stage1
    else
      render :new
    end
  end

  # PATCH/PUT /investors/1
  # PATCH/PUT /investors/1.json
  def update
    respond_to do |format|
      if @investor.update(investor_params)
        format.html { redirect_to @investor, notice: 'Investor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @investor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /investors/1
  # DELETE /investors/1.json
  def destroy
    @investor.destroy
    respond_to do |format|
      format.html { redirect_to investors_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_investor
      @investor = Investor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def investor_params
      params.require(:investor).permit(:name, :phone, :type, :company, :title, :description )
    end

    def investment_params
      params.require(:investor).require(:investment).permit(:name, :address, :description)
    end
end
