class MembersController < ApplicationController
  layout false

  before_action :authenticate_user!
  before_action do
    @project = Project.find(params[:project_id])
  end

  def index
    @members = @project.members_but(current_user)
  end

  def new
    @member = @project.members.build
  end

  def show
    @member = @project.members.find(params[:id])
  end

  def create
    user_id = member_params[:user_id]
    role = member_params[:role]

    if user_id
      # 直接添加用户即可
      user = User.find(user_id)
      @project.add_user(user, role: role)
      if @project.save
        render_success
      else
        render_fail(@project.errors.full_messages.to_s)
      end
    else
      #TODO 邀请制度的设计
    end
  end

  def destroy
  end

  private
  def member_params
    params.permit(:user_id, :name, :role)
  end
end
