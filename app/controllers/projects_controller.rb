class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show, :team, :invest, :new, :stage0, :stage1, :stage2 ]

  before_action( only: [:edit, :stage1, :stage2, :publish, :invest, :invite] ) do 
    @project = Project.find(params[:id])
  end

  def index
    @projects = Project.published
  end

  def new
    @project = Project.new
  end

  def edit
    @project = Project.find(params[:id])
  end

  # 创建第一步
  def create
    @project = Project.new( project_params )
    @project.add_owner( current_user )
    if @project.save
      render_success(nil, id: @project.id)
    else
      render_fail(nil, @project)
    end
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
    params.permit(:name, :oneword, :description, :industry, :city)
  end

end
