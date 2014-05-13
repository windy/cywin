module ApplicationHelper
  def active_for(controller_name, navbar_name)
    controller_name.to_sym == navbar_name.to_sym ? "active" : ""
  end

  def format_date(time)
    if time
      time.strftime("%Y.%m.%d")
    else
      ''
    end
  end
  
  def format_time(time)
    if time
      time.strftime("%Y-%m-%d %H:%S")
    else
      ''
    end
  end

  def format_status(status)
      case status
      when 'ready' then '未开始'
      when 'leader_needed' then '寻找领投人'
      when 'leader_need_confirmed' then '领投确认中'
      when 'opened' then '融资中'
      when 'closed' then '已结束'
      end
  end

  def format_start_end_time(s, e)
    "( #{format_date(s)} - #{format_date(e)} )"
  end
end
