class UsersController < ApplicationController

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
    @recent_events = @user.events.default_order.a_week
    respond_to do |format|
      format.html
      format.json
    end
  end

  def update
    @user = User.find(params[:id])
    authorize! :update, @user
  end
end
