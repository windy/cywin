class MembersController < ApplicationController
  layout false

  before_action :authenticate_user!
  before_action do
    @project = Project.find(params[:project_id])
  end

  def index
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
        render_success("添加成员成功")
      else
        render_fail(@project.errors.full_messages.to_s)
      end
    else
      #TODO 邀请制度的完善
      user = User.invite!( user_params ) do |u|
        u.skip_invitation = true
      end
      unless user.save
        render_fail(user.errors.full_messages)
        return
      end
      @project.add_user(user, role: role)
      if @project.save
        render_success
      else
        render_fail(@project.errors.full_messages.to_s)
      end
    end
  end

  def destroy
  end

  private
  def member_params
    params.permit(:user_id, :name, :role)
  end

  def user_params
    params.permit(:name, :email)
  end
end
