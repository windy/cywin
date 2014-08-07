json.array! @users do |user|
  json.extract! user, :id, :name, :description
  json.avatar user.avatar_url
  #$json.extract! user.investor, :title, :company
end
