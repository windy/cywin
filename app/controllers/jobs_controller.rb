class JobsController < ApplicationController

  def index
    @person_requires = PersonRequire.includes(:project).page(params[:page])
  end

  def search
    render :index
  end

end
