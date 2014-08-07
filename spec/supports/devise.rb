#module ControllerDevise
  def login_user
    before do
      single_login_user
    end
  end

  def login_admin
    before do
      single_login_user
      @user.add_role(:admin)
    end
  end

  def single_login_user
    request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  def relogin_user2
    sign_out @user
    request.env["devise.mapping"] = Devise.mappings[:user]
    @user2 = FactoryGirl.create(:zhang)
    sign_in @user2
  end
#end
