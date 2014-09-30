class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    start_with = params[:start_with]
    @events = Event.default_order.limit(Event::PER_PAGE)

    if start_with.present?
      @events = @events.where('created_at < ?', Time.at(start_with.to_i) )
    end

    @events = @events.related(current_user.id)

    unless @events.blank?
      start_with = @events[-1].created_at.to_i.to_s
    end
    respond_to do |format|
      format.json do
        render :json => {
          data: render_to_string("/timeline/events.html", :layout => false),
          start_with: start_with
        }
      end
    end
  end
end
