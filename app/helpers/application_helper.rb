module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

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
