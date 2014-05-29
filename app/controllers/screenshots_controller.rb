class ScreenshotsController < ApplicationController
  before_action :authenticate_user!

  def create
    @screenshot = Screenshot.new
    @screenshot.image = params[:file]
    if @screenshot.save
      render_success(nil, {
        id: @screenshot.id,
        url: @screenshot.image.url,
      })
    else
      render_fail( valid_on(@screenshot, :image) )
    end
  end

end
