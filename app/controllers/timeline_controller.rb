class TimelineController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = Event.default_order.limit(Event::PER_PAGE).related(current_user.id)
    @start_with = @events[-1].try(:created_at).to_i

    @my_projects = current_user.projects
    @star_projects = current_user.stars.includes(:project)
  end

end
