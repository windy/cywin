json.extract! @project, :name, :oneword, :link, :description
json.industries do
  json.array! @project.categories do |category|
    json.extract! category, :id, :name, :head_id
  end
end
json.city @project.cities_name
json.logo_id @project.logo.try(:id)
json.logo_url @project.logo.try(:image_url)
json.screenshot_url @project.screenshot_cover.try(:image_url)
json.screenshot_id @project.screenshot_cover.try(:id)

json.screenshots do
  json.array! @project.screenshots do |screenshot|
    json.partial! 'screenshots/screenshot', screenshot: screenshot
  end
end
