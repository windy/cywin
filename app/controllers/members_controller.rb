class MembersController < ApplicationController

  before_action :authenticate_user!, only: [:update, :create]
  before_action do
    @project = Project.find(params[:project_id])
  end

  def index
    members = @project.members_without_owner
    render_success(nil, data: members_json(members) )
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
    authorize! :update, @project
    user = User.find( params[:id] )
    member = @project.member( user )
    unless member
      render_fail('未找到指定的成员')
      return
    end

    if member.update(title: params[:title], description: params[:description])
      if params[:name] 
        if user.update(name: params[:name])
          render_success
        else
          render_fail('更新失败', user)
        end
      else
        render_success
      end
    else
      render_fail('更新失败', @member)
    end
  end

  def autocomplete
    search = params[:search]
    if search.nil?
      render_fail
    elsif search.include?('@')
      searched = User.where(email: search)
      if searched.empty?
        render_fail(nil, email: true, name: search.split('@')[0])
      else
        render_success( nil, data: users_json(searched), email: true )
      end
    else
      searched = User.where("name like ?", "%#{search}%").limit(5)
      render_success( nil, data: users_json(searched) )
    end
  end

  def invite
    authorize! :update, @project
    user = User.invite!( user_params )

    unless user.save
      render_fail(user.errors.full_messages)
      return
    end

    @project.add_user(user)

    if @project.save
      member = @project.reload.member( user )
      render_success(nil, data: member_json(member) )
    else
      render_fail(@project.errors.full_messages.to_s)
    end
  end

  def create
    authorize! :update, @project
    user_id = member_params[:user_id]

    user = User.find(user_id)
    @project.add_user(user)
    if @project.save
      member = @project.reload.member( user )
      render_success(nil, data: member_json(member) )
    else
      render_fail(@project.errors.full_messages.to_s)
    end
  end

  def destroy
    authorize! :update, @project
    user_id = params[:id]
    user = User.find(user_id)

    if @project.remove_user( user )
      render_success
    else
      render_fail
    end
  end

  private
  def member_params
    params.permit(:user_id, :name, :role)
  end

  def user_params
    params.permit(:name, :email)
  end

  def members_json(members)
    members.collect do |m|
      member_json(m)
    end
  end

  def member_json(member)
    user = member.user
    {
      member_id: member.id,
      user_id: user.id,
      name: user.name,
      url: user.avatar_url,
      title: member.title,
      description: member.description,
      confirmed: user.try(:confirmed?)
    }
  end

  # searched
  def users_json(users)
    users.collect do |u|
      user_json(u)
    end
  end

  def user_json(user)
    {
      avatar: user.avatar_url,
      name: user.name,
      user_id: user.id,
      joined: @project.member( user ).present?,
      confirmed: user.try(:confirmed?)
    }
  end
end
