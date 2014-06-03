class Users::ApplicationController < ApplicationController
  before_action do
    @user = User.find( params[:user_id] )
  end
end
