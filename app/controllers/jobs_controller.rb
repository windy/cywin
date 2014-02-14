class JobsController < ApplicationController
  def index
    @projects = Project.all
  end
end
