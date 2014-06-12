class InterestUsersController < ApplicationController
  before_action do
    @person_require = PersonRequire.find(params[:person_require_id])
    @project =@person_require.project
  end

  def index
    authorize! :update, @project
    @person_requires_users = @person_require.person_requires_users.includes(:user)
  end
end
