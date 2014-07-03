class RegistrationsController < Devise::RegistrationsController
  before_filter :update_sanitized_params, if: :devise_controller?

  def new
    super
  end

  def create
    if bit_enable?
      if ! InviteCode.validate_code(params[:code])
        render_fail('注册失败', errors: { code: '邀请码不正确或已被使用'} )
        return
      end
    end
    @user = User.new(sign_up_params)
    if @user.save
      flash[:notice] = '注册成功'
      sign_up(:user, @user)
      if bit_enable?
        InviteCode.mark_used(params[:code])
      end
      render_success
    else
      render_fail('注册失败', @user)
    end
  end

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:name, :email, :password, :password_confirmation)}
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:name, :email, :password, :password_confirmation, :current_password, :qq, :douban, :renren, :sinaweibo, :introduction, :work_experience, :education_experience, :fund_type, :min_invest, :max_invest, :focus_industry, :investment_philosophy, :added_value, :avatar)}
  end

  private
  def bit_enable?
    ENV['BIT'].to_i == 1
  end

  helper_method :bit_enable?
end
