class HomeController < ApplicationController
  def index
    if current_user
      render 'login'
    else
      render 'nologin'
    end
  end

  def welcome
  end
end
