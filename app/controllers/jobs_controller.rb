class JobsController < ApplicationController

  def index
    @projects = Project.all
  end

  def search
    render :index
  end

end
