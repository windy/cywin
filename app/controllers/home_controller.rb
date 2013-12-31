class HomeController < ApplicationController
  def index
    @users = User.all
    oauth_retrive
  end

  private
  def oauth_retrive
    user = current_user
    if not user.blank?
      authentication = user.authentications.first
      if not authentication.blank?
        access_token = authentication.access_token

        client = Weibo2::Client.new
        client.auth_code.authorize_url(:response_type => "token")
        client = Weibo2::Client.from_hash(:access_token => access_token, :expires_in => 86400)
        #response = client.users.show(:uid=>authentication.uid)
        
        begin
          response = client.statuses.update('client test')
          #puts response.parsed[:created_at]
          set_flash_message(:notice, 'Post success!')
        rescue Exception => e
          #set_flash_message(:alert, e)
        end

      end
    end
  end
end
