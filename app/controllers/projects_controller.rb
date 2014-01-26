class ProjectsController < ApplicationController

  def index
    @projects = Project.all
    if search_params[:search_name]
      @projects = @projects.where("name like %?%", search_params[:search_params])
    end
    if search_params[:type]
      #TODO
    end
    if search_params[:industry]
      @projects = @projects.find_by(industry: search_params[:industry])
    end
    # 城市相关, where1: 省, where2: 城市, where3: 地区
    if search_params[:district]
      @projects = @projects.find_by(where2: search_params[:district])
    end
  end

  def new
    @project = Project.new
  end

  # 创建第一步
  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to stage1_project_path(@project.id)
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
    @project = Project.find(params[:id])
  end

  private
  def project_params
    new_params = params
    new_params = params.require(:project) if params[:project]
    new_params.permit(:logo, :name, :oneword, :description, :stage, :where1, :where2 )
  end

  def search_params
    params.permit(:search_name, :type, :industry, :distinct)
  end
end
