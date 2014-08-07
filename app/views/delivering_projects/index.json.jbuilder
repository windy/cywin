json.array! @projects do |project|
  json.extract! project, :id, :name
  json.logo_url project.logo.image_url
end
