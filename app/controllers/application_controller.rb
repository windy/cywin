class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def render_success(msg = nil, data = {})
    render :json => {
      success: true,
      message: msg.to_s
    }.merge(data)
  end

  def render_fail(msg = nil, model = nil)
    res = {
      success: false,
      message: msg.to_s,
    }

    if model.kind_of?(Hash)
      res.merge!(model)
    else
      res.merge!( errors: flatten_errors(model.errors.messages) )
    end

    render :json => res
  end

  protected
  def flatten_errors(errors)
    errors.inject({}) { |res, (k,v)| res[k] = v.first; res }
  end

  def valid_on(model, column_name)
    if model.valid?
      return false
    else
      model.errors[column_name].first
    end
  end

end
