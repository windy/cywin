json.array! @users do |user|
  json.extract! user, :id, :name
  #$json.extract! user.investor, :title, :company
end
