class Settings::ProfilesController < ApplicationController
  def show
    @user = current_user
  end

  def update
  end
end
