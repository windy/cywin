class CardsController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize! :update, Investor
    @card = current_user.investor.card
  end

  def create
    authorize! :update, Investor
    @card = current_user.investor.card || current_user.investor.build_card
    @card.image = params[:file]
    if @card.save
      render_success(nil, {
        id: @card.id,
        url: @card.image.url,
      })
    else
      render_fail( valid_on(@card, :image) )
    end
  end
end
