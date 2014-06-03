class AvatarsController < ApplicationController
  def create
    user = User.find( params[:user_id] )
    user.avatar.try(:destroy!)
    @avatar = Avatar.new
    @avatar.image = params[:file]
    @avatar.user = user
    if @avatar.save
      render 'create'
    else
      render_fail(nil, valid_on(@avatar, :image) )
    end

  end
end
