class PersonRequiresController < ApplicationController

  before_action do
    @project = Project.find( params[:project_id] )
  end

  def index
    @person_requires = @project.person_requires
    if @person_requires.blank?
      render_fail
    else
      render 'index'
    end
  end

  def create
    authorize! :update, @project
    person_require = PersonRequire.new(  person_require_params )
    person_require.project = @project
    if person_require.save
      render_success(nil, id: person_require.id)
    else
      render_fail('创建失败', person_require)
    end
  end

  def update
    authorize! :update, @project
  end

  def destory
    authorize! :update, @project
  end

  private
  def person_require_params
    params.permit(:title, :description, :pay, :option, :stock, :remote, :part)
  end

end
