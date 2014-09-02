unless money_require
  json.null!
else
  json.extract! money_require, :id, :money, :share, :deadline, :status, :min_money, :maxnp, :carry, :leader_word, :project_id
  json.time_progress money_require.time_progress
  json.format_status format_status(money_require.status)
  if money_require.opened_at.present?
    # 开始与结束时间
    json.opened_at format_date(money_require.opened_at)
    json.ended_at format_date(money_require.ended_at)
    json.format_start_end_time format_start_end_time(money_require.opened_at, money_require.ended_at)
  end
  
  if money_require.opened?
    # 剩余天数
    json.syndicate_money money_require.syndicate_money
  end
  json.left money_require.left
  json.syndicate_progress money_require.progress

  # 可投资信息
  json.syndicate do
    # behave 当前行为的支持
    if current_user.nil?
      json.behave :need_login
    elsif ! current_user.has_role?(:investor)
      json.behave :need_be_investor
    else
      if money_require.ready?
        json.behave :ready
      elsif money_require.leader_needed?
        json.behave :need_leader
      elsif money_require.leader_need_confirmed?
        if money_require.leader_user == current_user
          # 是 leader 本人
          json.can true
          json.behave :leader_confirm
        else
          json.behave :leader_confirming
        end
      elsif money_require.opened?
        json.can true
        # 已经投资过
        if money_require.already_money(current_user)
          json.behave :add
          json.already_money money_require.already_money(current_user)
          json.already_investment_id money_require.already_investment_id(current_user)
        else
          json.behave :invest
        end
      end
    end
  end

  if money_require.closed?
    json.extract! money_require, :cost, :success
  end

  if money_require.leader_user
    json.leader do
      json.extract! money_require.leader_user, :name, :id, :description
      json.avatar money_require.leader_user.avatar_url
      json.me money_require.leader_user == current_user
    end
  end

  json.law_iterms do
    json.array! money_require.law_iterms do |law_iterm|
      json.extract! law_iterm, :title, :description, :id
    end
  end
end
