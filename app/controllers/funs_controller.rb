class FunsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find( params[:id] )
    current_user.add_fun(user)
    # 不会出现失败, 无须处理异常
    render_success
  end

  def destroy
    user = User.find( params[:id] )
    current_user.remove_fun(user)
    render_success
  end
end
