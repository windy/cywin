class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  # 创建第一步
  def create
    @project = Project.new(project_params)
    if @project.save
      render :stage1
    else
      render :new
    end
  end

  # 创建第二步
  def stage1
    @project = Project.find(params[:id])
    if request.post?
      @project.update_attributes(project_params)
      if @project.save
        redirect_to stage2_project_path(params[:id])
        return
      else
        render :stage1
        return
      end
    # get
    else
      render :stage1
      return
    end
  end

  # 创建第三步
  def stage2
    @project = Project.find(params[:id])
    if request.post?
      @project.update_attributes(project_params)
      if @project.save
        redirect_to '/'
        return
      else
        render :stage2
        return
      end
    # get
    else
      render :stage2
      return
    end
  end

  def update
  end

  def show
  end

  private
  def project_params
    new_params = params
    new_params = params.require(:project) if params[:project]
    new_params.permit(:name, :oneword, :description, :stage, :where1, :where2 )
  end
end
