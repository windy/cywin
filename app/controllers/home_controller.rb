class HomeController < ApplicationController
  def index
    if current_user
      @events = Event.default_order.limit(Event::PER_PAGE).related(current_user.id)
      @start_with = @events[-1].try(:created_at).to_i
      render 'login'
    else
      render 'nologin'
    end
  end

  def welcome
  end
end
