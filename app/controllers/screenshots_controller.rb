class ScreenshotsController < ApplicationController
  before_action :authenticate_user!

  def create
    @screenshot = Screenshot.new
    @screenshot.image = params[:file]
    @screenshot.name = params[:file].original_filename
    if @screenshot.save
      render 'create'
    else
      render_fail( valid_on(@screenshot, :image) )
    end
  end

end
