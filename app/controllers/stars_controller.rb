class StarsController < ApplicationController
  before_action :authenticate_user!

  def create
    project = Project.find(params[:id])
    current_user.add_star(project)
    # 不会出现失败, 无须处理异常
    render_success("关注项目成功")
  end

  def destroy
    project = Project.find(params[:id])
    current_user.remove_star(project)
    # 同上
    render_success("取消关注成功")
  end
end
