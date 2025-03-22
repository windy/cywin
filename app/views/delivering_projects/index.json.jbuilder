json.array! @projects do |project|
  json.extract! project, :id, :name
  json.logo_url project.logo.present? ? project.logo.image_url : ActionController::Base.helpers.asset_path('default-project.jpg')
end