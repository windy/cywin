class Admin::DashboardController < Admin::ApplicationController
  def index
    @users_count = User.count
    @projects_count = Project.count
    @money_requires_count = MoneyRequire.count
    @money_requires_success_count = MoneyRequire.all.find_all { |m| m.progress >= 1 }.size
    @person_requires_count = PersonRequire.count
  end
end
