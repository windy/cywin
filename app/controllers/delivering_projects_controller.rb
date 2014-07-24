class DeliveringProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = current_user.projects
  end

  def update 
    @project = current_user.projects.find(params[:id])
    @delivered_user = User.find(params[:user_id])

    Message.create(
      user: @delivered_user,
      action: Message::DELIVER_PROJECT,
      project: @project,
    )

    render_success
  end
end
