module ControllerDevise
  def login_user
    before do
      single_login_user
    end
  end

  def single_login_user
    request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user)
    sign_in @user
  end
end
