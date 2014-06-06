class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def autocomplete
    max = 5
    search = params.permit(:search)[:search]
    if search.nil?
      searched = Category.limit(max)
      render_success( nil, data: categories_json(searched) )
    else
      searched = Category.where("name like ?", "%#{search}%").limit(max)
      if searched.empty?
        render_fail
      else
        render_success( nil, data: categories_json(searched) )
      end
    end
  end

  private
  def categories_json( categories )
    categories.collect do | category |
      {
        name: category.name
      }
    end
  end
end
