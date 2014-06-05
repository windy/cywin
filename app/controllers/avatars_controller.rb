class AvatarsController < ApplicationController
  def create
    @avatar = Avatar.new
    @avatar.image = params[:file]
    if @avatar.valid?
      user = User.find( params[:user_id] )
      user.avatar.try(:destroy!)
      @avatar.user = user
      @avatar.save!
      render 'create'
    else
      render_fail( valid_on(@avatar, :image) )
    end

  end
end
