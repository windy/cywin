class DeliveringProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = current_user.projects
  end

  def create
    @projects = current_user.projects.where(id: params[:ids].to_a)
    @delivered_user = User.find(params[:user_id])

    @projects.each do |project|
      Message.create(
        user: @delivered_user,
        action: Message::DELIVER_PROJECT,
        project: project,
      )
    end

    render_success
  end
end
