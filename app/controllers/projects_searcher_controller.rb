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
  end

  private
  def search_params
    params.permit(:search_name, :type, :industry, :district)
  end

end
