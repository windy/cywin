json.array! @money_requires do |money_require|
  json.extract! @money_require, :id, :money, :share, :status
  json.start format_date(@money_require.created_at)
  json.end format_date(@money_require.deadline)
  json.leader do 
    json.extract! @money_require.leader_user, :name, :id
  end
end
