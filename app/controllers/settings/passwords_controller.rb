class Settings::PasswordsController < Settings::ApplicationController
  def show
  end

  def update
    if @user.update_with_password(params.require(:user).permit!)
      flash[:notice] = '修改密码成功'
      sign_in(@user, bypass: true)
      redirect_to settings_password_path
    else
      flash.now[:error] = '修改密码失败'
      render :show
    end
  end
end
