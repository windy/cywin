json.extract! @money_require, :id, :money, :share, :deadline, :status
json.start format_date(@money_require.created_at)
if @money_require.leader_user
  json.leader do 
    json.extract! @money_require.leader_user, :name, :id
  end
end
