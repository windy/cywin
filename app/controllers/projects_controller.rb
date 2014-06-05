class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :team, :invest]

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
  end

  # 创建第一步
  def create
    authorize! :create, Project
    @project = Project.new( project_params )

    if params[:industry].blank?
      @project.errors.add(:industry, '必须选择一个分类')
      render_fail('创建失败', @project)
      return
    else
      category = Category.find_or_create_by(name: params[:industry])
      @project.categories << category
    end
    
    if params[:city].blank?
      @project.errors.add(:city, '必须选择一个城市')
      render_fail('创建失败', @project)
      return
    else
      city = City.find_or_create_by(name: params[:city])
      @project.cities << city
    end

    if logo_params[:logo_id]
      @project.logo = Logo.find( logo_params[:logo_id] )
    else
      render_fail('创建失败', logo_error: '必须上传图片') 
      return
    end

    @project.add_owner( current_user )
    if @project.save
      render_success(nil, id: @project.id)
    else
      render_fail('创建失败', @project)
    end
  end

  def dirty_update
    @project = Project.find( params[:id] )
    authorize! :update, @project
    if @project.update(description: params[:description])
      render_success
    else
      render_fail
    end
  end

  def screenshots_update
    @project = Project.find( params[:id] )
    authorize! :update, @project
    @project.screenshots = params[:ids].to_a.map do |id|
      Screenshot.find(id)
    end
    if @project.save(validate: false)
      render_success
    else
      render_fail
    end
  end

  def update
    @project = Project.find( params[:id] )
    authorize! :update, @project

    if logo_params[:logo_id]
      logo = Logo.find( logo_params[:logo_id] )
      @project.logo = logo
    end

    if params[:industry].blank?
      @project.errors.add(:industry, '必须选择一个分类')
      render_fail('创建失败', @project)
      return
    else
      @project.categories.delete_all
      category = Category.find_or_create_by(name: params[:industry])
      @project.categories << category
    end

    if params[:city].blank?
      @project.errors.add(:city, '必须选择一个城市')
      render_fail('创建失败', @project)
      return
    else
      @project.cities.delete_all
      city = City.find_or_create_by(name: params[:city])
      @project.cities << city
    end

    if @project.update( project_params )
      render_success
    else
      render_fail('更新失败', @project)
    end
  end

  def show
    @project = Project.find(params[:id])
    respond_to do |format|
      format.json { render partial: "project" }
      format.html
    end
  end

  def team
    @project = Project.find( params[:id] )
  end

  def invest
    @project = Project.find( params[:id] )
    @money_require = @project.opened_money_require
  end

  private
  def project_params
    params.permit(:name, :oneword, :description)
  end

  def logo_params
    params.permit(:logo_id)
  end

end
