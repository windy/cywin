class Settings::ApplicationController < ApplicationController
  before_action :authenticate_user!
  
  before_action do
    @user = current_user
  end
end
