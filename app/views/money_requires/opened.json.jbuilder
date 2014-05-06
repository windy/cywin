json.money_require do
  unless @money_require
    json.nil!
  else
    json.extract! @money_require, :id, :money, :share, :status
    json.start format_date(@money_require.created_at)
    if @money_require.leader_user
      json.leader do 
        json.extract! @money_require.leader_user, :name, :id
      end
    end
  end
end
