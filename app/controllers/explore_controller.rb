class ExploreController < ApplicationController

  def index
    @recommends = Recommend.default_order.includes(:project).limit(9)
  end

  def all
    @heads = Head.all
    @cities = City.all
    @projects = Project.default_order.page( params[:page] )
  end

  def search
    @heads = Head.all
    @cities = City.all
    category_ids = nil

    if params[:head_id].present?
      @head = Head.find(params[:head_id])
      category_ids = @head.categories.collect(&:id)
    end

    @projects = Project.search do
      with(:category_ids, category_ids) if category_ids
      with(:city_ids, [params[:city_id]]) if params[:city_id].present?
      fulltext "*#{params[:q]}*"
      paginate page: params[:page], per_page: Project::PER_PAGE
    end.results
    render :all
  end

  def categories
    @categories = Category.all
  end

  def trend
    @how_much = case params[:how_much]
    when "most_a_week"
      :most_a_week
    when "most_a_month"
      :most_a_month
    else
      :most_a_week
    end

    count = 20

    @cond = case params[:cond]
    when "by_investments"
      @investments_most = Investment.send(@how_much, count)
      :by_investments
    when "by_stars"
      @stars_most = Star.send(@how_much, count)
      :by_stars
    when "by_times"
      @projects_most = Project.send(@how_much, count)
      :by_times
    when "by_talks"
      @talks_most = Talk.send(@how_much, count)
      :by_talks
    else
      @investments_most = Investment.most_a_week
      :by_investments
    end
  end

end
