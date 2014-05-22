json.extract! investment, :id, :money
json.created_at format_date(investment.created_at)
json.updated_at format_date(investment.updated_at)
json.user do
  json.extract! investment.user, :name, :id, :description
  json.avatar investment.user.avatar_url
end
