class HomeController < ApplicationController
  def index
    if current_user
      @events = current_user.events
      render 'login'
    else
      render 'nologin'
    end
  end

  def welcome
  end
end
