class Users::FunsController < Users::ApplicationController

  def index
    @funs = Fun.by(@user.id).includes(:user).page(params[:page])
  end

end
