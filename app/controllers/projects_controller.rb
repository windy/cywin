class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to '/'
    else
      render :new
    end
  end

  def update
  end

  def show
  end
  private
  def project_params
    params.require(:project).permit( :title, :price, :description, :stage, :where1, :where2 )
  end
end
