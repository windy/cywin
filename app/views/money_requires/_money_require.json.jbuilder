unless @money_require
  json.null!
else
  json.extract! @money_require, :id, :money, :share, :deadline, :status
  json.start format_date(@money_require.created_at)
  if @money_require.leader_user
    json.leader do
      json.extract! @money_require.leader_user, :name, :id
      json.avatar @money_require.leader_user.avatar_url
    end
  end
end
