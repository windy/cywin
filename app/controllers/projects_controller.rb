class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :team, :invest]

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

    if params[:industries].blank?
      @project.errors.add(:industries, '必须选择一个分类')
      render_fail('创建失败', @project)
      return
    else
      industries = parse_industries(params[:industries])
      industries.each do |industry|
        category = Category.find(industry[:id])
        @project.categories << category
      end
    end
    
    if params[:city].blank?
      @project.errors.add(:city, '必须选择一个城市')
      render_fail('创建失败', @project)
      return
    else
      city = City.find_or_create_by(name: params[:city])
      @project.cities << city
    end

    if params[:logo_id].present?
      @project.logo = Logo.find( params[:logo_id] )
    else
      # render_fail('创建失败', logo_error: '必须上传 Logo') 
      # return
    end

    if params[:screenshot_id].present?
      @project.screenshots << Screenshot.find( params[:screenshot_id] )
    else
      # render_fail('创建失败', screenshot_error: '必须上传截图') 
      # return
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

    if params[:logo_id]
      logo = Logo.find( params[:logo_id] )
      @project.logo = logo
    end

    if params[:industries].blank?
      @project.errors.add(:industries, '至少要选择一个分类')
      render_fail('创建失败', @project)
      return
    else
      @project.categories.delete_all
      industries = parse_industries(params[:industries])
      industries.each do |industry|
        category = Category.find(industry[:id])
        @project.categories << category
      end
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

    if params[:screenshot_id].present?
      @project.screenshots << Screenshot.find( params[:screenshot_id] )
    # else
    #   render_fail('创建失败', screenshot_error: '必须上传截图') 
    #   return
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
    @owner = @project.owner
    @owner_member = @project.member( @owner )
    @members = @project.members_but( @owner )
  end

  def invest
    @project = Project.find( params[:id] )
    @star_users = @project.star_users
    @money_require = @project.opened_money_require
  end

  private
  def project_params
    params.permit(:name, :oneword, :link, :description)
  end

  def logo_params
    params.permit(:logo_id)
  end

  # 解析industries参数，处理JSON字符串或对象数组
  def parse_industries(industries_param)
    return [] if industries_param.blank?
    
    # 如果已经是数组，直接返回
    if industries_param.is_a?(Array)
      return industries_param.map do |hash|
        hash.symbolize_keys
      end
    end
    
    # 尝试解析JSON字符串
    if industries_param.is_a?(String)
      begin
        parsed = JSON.parse(industries_param)
        parsed = parsed.is_a?(Array) ? parsed : [parsed]
        return parsed.map { |h| h.symbolize_keys }
      rescue JSON::ParserError => e
        Rails.logger.error("Industries参数解析错误: #{e.message}")
        return []
      end
    end
    
    # 如果是其他类型，尝试转换为数组
    industries_param.to_a.map { |h| h.symbolize_keys }
  end
end