class MoneyRequiresController < ApplicationController
  def new
  end

  # 发起一个新的融资
  def create
    @project = Project.find(params.require(:money_require).permit(:project_id)[:project_id])
    money_require_params = params.require(:money_require).permit(:money, :share, :description, :deadline)
    @money_require = MoneyRequire.new(money_require_params)
    @money_require.project = @project
    if @money_require.save
      @money_require.preheat!
      flash[:notice] = "发起融资成功"
      render template: 'syndicates/syndicate_info', layout: false
    else
      render_fail(@money_require.errors.full_messages.to_s)
    end
  end

  # 添加一个领投人
  def add_leader
  end

  # 关闭打开中的融资
  def close
    @money_require = MoneyRequire.find(params[:id])
    @project = @money_require.project
    begin
      @money_require.close!
      flash[:notice] = "关闭融资成功"
      render template: 'syndicates/syndicate_info', layout: false
    rescue =>e
      render_fail(e.message)
    end
  end

  def update
  end
end
