class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show, :team, :invest, :new, :stage0, :stage1, :stage2 ]

  before_action( only: [:edit, :stage1, :stage2, :publish, :invest, :invite] ) do 
    @project = Project.find(params[:id])
  end

  #load_and_authorize_resource

  def index
    @projects = Project.published
  end

  def new
    @project = Project.new
  end

  def stage0
    @project = Project.find(params[:id])
    render :new
  end

  def edit
    @project = Project.find(params[:id])
  end

  # 创建第一步
  def create
    @project = Project.new(project_params)
    @project.add_owner( current_user )
    if @project.save
      redirect_to stage1_project_path(@project.id)
    else
      render :new
    end
  end

  # 创建第二步
  def stage1
  end

  # 创建第三步
  def stage2
  end

  def publish
    if @project.publish
      flash[:notice] = "发布成功"
      render_success("发布项目成功")
    else
      render_fail("发布失败")
    end
  end

  # 发起一个新的招聘
  def invite
    person_requires_params = params.require(:person_require).permit(:title, :pay, :stock, :option, :description)
    @person_require = PersonRequire.new(person_requires_params)
    @project.person_requires << @person_require
    if @project.save
      render_success
    else
      render_fail(@project.errors)
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update( project_params )
      redirect_to stage1_project_path(@project)
    else
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def team
  end

  def invest
  end

  private
  def project_params
    new_params = params
    new_params = params.require(:project) if params[:project]
    new_params.permit(:id, :logo, :logo_cache, :name, :oneword, :description, :stage, :where1, :where2, :where3, contact_attributes: [ :address, :phone, :qq, :weixin, :weibo ])
  end

end
