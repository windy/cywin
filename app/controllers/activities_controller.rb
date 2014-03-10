class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @events = Event.where(user_id: current_user.id).order(created_at: :desc)
  end
end
