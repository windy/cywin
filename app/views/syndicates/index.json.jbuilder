json.leader do
  json.extract! @money_require.leader_user, :name, :id, :description
  json.avatar @money_require.leader_user.avatar_url
end
json.investments do
  json.array! @investments do |investment|
    json.partial! 'investment', investment: investment
  end
end
