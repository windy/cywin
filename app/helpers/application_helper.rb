module ApplicationHelper
  def active_for(controller_name, navbar_name)
    controller_name.to_sym == navbar_name.to_sym ? "active" : ""
  end

  def format_date(time)
    time.strftime("%Y.%m.%d")
  end
  
  def format_time(time)
    time.strftime("%Y-%m-%d %H:%S")
  end
end
