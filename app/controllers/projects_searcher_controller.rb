class ProjectsSearcherController < ApplicationController
  layout false
 
  def index
    @projects = Project.all
    unless search_params[:search_name].blank?
      @projects = @projects.where("name like ?", "%#{search_params[:search_name]}%")
    end
    unless search_params[:type].blank?
      #TODO
    end
    unless search_params[:industry].blank?
      @projects = @projects.where(industry: search_params[:industry])
    end
    # 城市相关, where1: 省, where2: 城市, where3: 地区
    unless search_params[:district].blank?
      @projects = @projects.where(where2: search_params[:district])
    end
  end

  private
  def search_params
    params.permit(:search_name, :type, :industry, :district)
  end

end
