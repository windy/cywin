class Users::ProjectsController < Users::ApplicationController
  def index
    @members = @user.members.includes(:project)
  end
end
