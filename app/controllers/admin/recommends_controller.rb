class Admin::RecommendsController < Admin::ApplicationController
  def index
    @recommends = Recommend.all
  end

  def new
    @recommend = Recommend.new
  end

  def create
    @recommend = Recommend.new( recommend_params )  
    if @recommend.save
      flash[:notice] = '创建成功'
      redirect_to admin_recommends_path
    else
      render :new
    end
  end

  def destroy
    @recommend = Recommend.find( params[:id] )
    if @recommend.destroy
      flash[:notice] = '取消推荐成功'
      redirect_to admin_recommends_path
    else
      flash[:alert] = '取消推荐成功'
      redirect_to admin_recommends_path
    end
  end

  private
  def recommend_params
    params.require(:recommend).permit(:project_id, :description)
  end
end
