module ProjectsHelper

  def project_categories_link(project)
    project.categories.collect do |category|
      link_to category.name, search_explore_index_path(head_id: category.head_id)
    end.join(', ')
  end

  def project_cities_link(project)
    project.cities.collect do |city|
      link_to city.name, search_explore_index_path(city_id: city.id)
    end.join(', ')
  end
end
