class PersonRequiresController < ApplicationController

  before_action do
    @project = Project.find( params[:project_id] )
  end

  def admin
    authorize! :update, @project
    @person_requires = @project.person_requires.default_order
  end

  def new
    authorize! :update, @project
    @person_require = @project.person_requires.build
  end

  def edit
    authorize! :update, @project
    @person_require = @project.person_requires.find( params[:id] )
  end

  def open
    authorize! :update, @project
    @person_require = @project.person_requires.find( params[:id] )

    if @person_require.open
      flash[:notice] = '打开招聘需求成功'
      redirect_to admin_project_person_requires_path(@project)
    else
      flash.now[:error] = '失败'
      render :admin
    end
  end

  def close
    authorize! :update, @project
    @person_require = @project.person_requires.find( params[:id] )
    if @person_require.close
      flash[:notice] = '关闭招聘需求成功'
      redirect_to admin_project_person_requires_path(@project)
    else
      flash.now[:error] = '失败'
      render :admin
    end
  end

  def index
    @person_requires = @project.person_requires.opened
    if @person_requires.blank?
      render_fail
    else
      render 'index'
    end
  end

  def create
    authorize! :update, @project
    @person_require = PersonRequire.new(  person_require_params )
    @person_require.project = @project
    if @person_require.save
      respond_to do |format|
        format.json { render_success(nil, id: @person_require.id) }
        format.html do
          flash[:notice] = '创建成功'
          redirect_to admin_project_person_requires_path(@project)
        end
      end
    else
      respond_to do |format|
        format.json { render_fail('创建失败', @person_require) }
        format.html do
          flash.now[:error] = '创建失败'
          render :new
        end
      end
    end
  end

  def update
    authorize! :update, @project
    @person_require = @project.person_requires.find( params[:id] )
    if @person_require.update( person_require_params )
      flash[:notice] = '更新成功'
      redirect_to admin_project_person_requires_path
    else
      flash.now[:error] = '更新失败'
      render :edit
    end
  end

  def interest
    @person_require = @project.person_requires.find( params[:id] )
    current_user.person_requires << (@person_require)

    if current_user.save
      render_success
    else
      render_fail
    end
  end

  private
  def person_require_params
    params.permit(:title, :description, :pay, :option, :stock, :remote, :part).presence or
      params.require(:person_require).permit(:title, :description, :pay, :option, :stock, :remote, :part)
  end

end
