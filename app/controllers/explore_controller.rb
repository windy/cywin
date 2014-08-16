class ExploreController < ApplicationController

  def index
    @recommends = Recommend.default_order.includes(:project).limit(6)
    @categories = Category.limit(6)
    @newest_projects = Project.default_order.limit(6)
  end

  def all
    @heads = Head.all
    @projects = Project.default_order.page( params[:page] )
  end

  def search
    @heads = Head.all
    category_ids = nil

    if params[:head_id].present?
      @head = Head.find(params[:head_id])
      category_ids = @head.categories.collect(&:id)
    end

    @projects = Project.search do
      with(:category_ids, category_ids) if category_ids
      fulltext "*#{params[:q]}*"
      paginate page: params[:page], per_page: Project::PER_PAGE
    end.results
    #binding.pry
    render :all
  end

  def categories
    @categories = Category.all
  end

  def trend
    @stars_most_a_week = Star.most_a_week
    @investments_most_a_week = Investment.most_a_week
    @talks_most_a_week = Talk.most_a_week
  end

end
