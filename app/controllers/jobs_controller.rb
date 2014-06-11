class JobsController < ApplicationController

  def index
    @person_requires = PersonRequire.opened.default_order.includes(:project).page(params[:page])
  end

  def search
    @person_requires = PersonRequire.search do
      fulltext "*#{params[:q]}*"
      paginate page: params[:page], per_page: PersonRequire::PER_PAGE
      with(:status, 'opened')
    end.results
    render :index
  end

end
