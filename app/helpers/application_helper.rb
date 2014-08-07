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
      when 'leader_needed' then '预热中'
      when 'leader_need_confirmed' then '领投确认中'
      when 'opened' then '融资中'
      when 'closed' then '已结束'
      end
  end

  def format_start_end_time(s, e)
    "( #{format_date(s)} - #{format_date(e)} )"
  end

  def human_boolean(bool)
    bool ? '是' : '否'
  end

  def human_person_require_status(person_require)
    if person_require.opened?
      '正在招聘'
    else
      '已关闭'
    end
  end

  def human_investor_status(investor)
    case investor.status
    when 'drafted'
      '草稿'
    when 'applied'
      '已提交待审批'
    when 'passed'
      '已通过'
    when 'rejected'
      '已被拒绝'
    end
  end

  def human_investor_audit_status(ia)
    case ia.status
    when 'applied'
      '已提交待审批'
    when 'passed'
      '已通过'
    when 'rejected'
      '已被拒绝'
    end
  end

end
