class PersonRequiresController < ApplicationController

  before_action do
    @project = Project.find( params[:project_id] )
  end

  def index
    person_requires = @project.person_requires
    if person_requires.empty?
      render_fail
    else
      render_success( nil, data: person_requires_json(person_requires) )
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

  def person_requires_json(person_requires)
    person_requires.collect do |p|
      person_require_json(p)
    end
  end

  def person_require_json(person_require)
    {
      id: person_require.id,
      title: person_require.title,
      description: person_require.title,
      pay: person_require.pay,
      option: person_require.option,
      stock: person_require.stock,
      remote: person_require.remote,
      part: person_require.part,
    }
  end
end
