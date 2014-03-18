class Admin::ApplicationController < ApplicationController
  layout 'admin/application'
  before_action :authenticate_user!
  before_action do
    raise CanCan::AccessDenied unless current_user.has_role?(:admin)
  end
end
