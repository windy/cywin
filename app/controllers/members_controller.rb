class MembersController < ApplicationController

  before_action :authenticate_user!, only: [:update, :create]
  before_action do
    @project = Project.find(params[:project_id])
  end

  def index
    members = @project.members_without_owner
    render_success(nil, data: {
    })
  end

  def new
    @member = @project.members.build
  end

  def show
    @member = @project.members.find(params[:id])
  end

  def owner
    owner = @project.owner
    owner_member = @project.member( owner )
    render_success(nil, data: {
      avatar: owner.avatar_url,
      name: owner.name,
      user_id: owner.id,
      description: owner_member.description,
      title: owner_member.title,
    })
  end

  def team_story
    render_success(nil, team_story: @project.team_story)
  end

  def update_team_story
    authorize! :update, @project
    if @project.update( team_story: params[:team_story] )
      render_success
    else
      render_fail('更新失败')
    end
  end

  def update
    user = User.find( params[:id] )
    member = @project.member( user )
    authorize! :update, @project
    if member
      if member.update(title: params[:title], description: params[:description]) && user.update(name: params[:name])
        render_success
      else
        render_fail('更新失败')
      end

    else
      render_fail('未找到指定的成员')
    end
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

  def member_json(member)
  end
end
