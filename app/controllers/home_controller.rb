class HomeController < ApplicationController

  def index
    if current_user
      @events = Event.default_order.limit(Event::PER_PAGE).related(current_user.id)
      @start_with = @events[-1].try(:created_at).to_i
      render 'login'
    else
      @recommends = Recommend.all.default_order.includes(:project).limit(3)
      @investors = Investor.all.limit(3)
      @person_requires = PersonRequire.all.limit(3)
      render 'nologin'
    end
  end

  def welcome
    @recommends = Recommend.all.default_order.includes(:project).limit(3)
  end

  def search
    @q = params[:q]
    @projects = Project.search do
      fulltext "*#{params[:q]}*"
      paginate page: 1, per_page: 5
    end.results

    @investors = Investor.search do
      fulltext "*#{params[:q]}*"
      paginate page: 1, per_page: 5
      with(:status, 'passed')
    end.results

    @person_requires = PersonRequire.search do
      fulltext "*#{params[:q]}*"
      paginate page: 1, per_page: 5
      with(:status, 'opened')
    end.results
  end

end
