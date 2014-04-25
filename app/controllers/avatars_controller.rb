class AvatarsController < ApplicationController
  def create
    user = User.find( params[:user_id] )
    user.avatar.try(:destroy!)
    @avatar = Avatar.new
    @avatar.image = params[:file]
    @avatar.user = user
    if @avatar.save
      render_success(nil, {
        id: @avatar.id,
        url: @avatar.image.url,
      })
    else
      render_fail( valid_on(@avatar, :image) )
    end

  end
end
