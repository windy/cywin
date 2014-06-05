class ExploreController < ApplicationController
  def index
    @recommend_projects = Recommend.order(created_at: :desc).limit(6)
    @categories = Category.limit(6)
    @newest_projects = Project.order(created_at: :desc).limit(6)
  end

  def all
    @projects = Project.default_order.page( params[:page] )
  end

  def categories
    @categories = Category.all
  end

  def trend
  end
end
