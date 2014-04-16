class UsersController < ApplicationController
  #before_filter :authenticate_user!

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
  end

  def autocomplete
    search = params.permit(:search)[:search]
    if search.nil?
      render_fail
    else
      searched = User.where("name like ?", "%#{search}%").select("id", "name")
      render_success(nil, data: searched)
    end
  end

  def email_validate
    email = params[:email]
    user = User.new(email: email)
    error_message = valid_on(user, :email)
    if error_message
      render_fail(error_message)
    else
      render_success
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def change_password
  end

  def starred
  end

  def update
    authorize! :update, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user], :as => :admin)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end
end
