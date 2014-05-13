class ExploreController < ApplicationController
  def index
  end

  def all
  end

  def categories
    @categories = Category.all
  end

  def trend
  end
end
