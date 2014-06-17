class CitiesController < ApplicationController
  def index
  end

  def autocomplete
    max = 5
    search = params[:search]
    if search.nil?
      searched = City.limit(max)
      render_success( nil, data: cities_json(searched) )
    else
      searched = City.where("name like ?", "%#{search}%").limit(max)
      render_success( nil, data: cities_json(searched) )
    end
  end

  private
  def cities_json(cities)
    cities.collect do | m |
      {
        name: m.name
      }
    end
  end
end
