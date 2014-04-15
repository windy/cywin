class RegistrationsController < Devise::RegistrationsController
  before_filter :update_sanitized_params, if: :devise_controller?

  def new
    super
  end

  def create
    @user = User.new(sign_up_params)
    if @user.save
      flash[:notice] = '注册成功'
      render :json=> { success: true }
    else
      render :json=> { success: false, message: '注册失败' }
    end
  end

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:name, :email, :password, :password_confirmation)}
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:name, :email, :password, :password_confirmation, :current_password, :qq, :douban, :renren, :sinaweibo, :introduction, :work_experience, :education_experience, :fund_type, :min_invest, :max_invest, :focus_industry, :investment_philosophy, :added_value, :avatar)}
  end

end
