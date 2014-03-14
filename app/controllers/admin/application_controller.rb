class Admin::ApplicationController < ApplicationController
  layout 'admin/application'
  before_action :authenticate_user!
  before_action do
    unauthorized! unless current_user.has_role(:admin?)
  end
end
