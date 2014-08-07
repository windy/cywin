class Users::InvitementsController < Users::ApplicationController
  def index 
    @investments = @user.investments.default_order.includes(:money_require)
  end
end
