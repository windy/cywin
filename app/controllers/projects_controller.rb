class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @projects = Project.published
  end

  def new
    authorize! :create, Project
    @project = Project.new
  end

  def edit
    @project = Project.find(params[:id])
    authorize! :update, @project
    #TODO
  end

  # 创建第一步
  def create
    authorize! :create, Project
    @project = Project.new( project_params )
    @project.add_owner( current_user )
    if @project.save
      render_success(nil, id: @project.id)
    else
      render_fail(nil, @project)
    end
  end

  def update
    @project = Project.find( params[:id] )
    authorize! :update, @project
    if @project.update( project_params)
      render_success
    else
      render_fail(nil, @project)
    end
  end

  def show
    @project = Project.find(params[:id])
    respond_to do |format|
      format.json do
        render_success(nil, data: {
          name: @project.name,
          oneword: @project.oneword,
          description: @project.description,
        })
      end
    end
  end

  private
  def project_params
    params.permit(:name, :oneword, :description, :industry, :city)
  end

end
