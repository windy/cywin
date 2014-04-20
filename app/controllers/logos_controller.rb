class LogosController < ApplicationController
  before_action :authenticate_user!
  def create
    @logo = Logo.new
    @logo.image = params[:file]
    @logo.save!
    render_success(nil, {
      id: @logo.id,
      url: @logo.image.url,
    })
  end
end
