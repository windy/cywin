class LogosController < ApplicationController
  before_action :authenticate_user!
  def create
    @logo = Logo.new
    @logo.image = params[:file]
    if @logo.save
      render_success(nil, {
        id: @logo.id,
        url: @logo.image.url,
      })
    else
      render_fail( valid_on(@logo, :image) )
    end
  end
end
