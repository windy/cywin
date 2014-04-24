class Admin::ProjectsController < Admin::ApplicationController
  def index
    @projects = Project.all
  end
end
