class MoneyRequiresController < ApplicationController
  before_action :set_money_require, only: [ :add_leader, :leader_confirm, :close ]
  before_action :authenticate_user!

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

  # 添加一个领投人, 并等待确认
  def add_leader
    leader_id = params.permit(:leader_id)[:leader_id]
    if @money_require.add_leader_and_wait_confirm(leader_id)
      render_success("添加领投人成功")
    else
      render_fail(@money_require.errors.full_messages.to_s)
    end
  end

  def leader_confirm
    if @money_require.leader_id != current_user.id
      render_fail("必须领投人本人确认")
      return
    end

    if @money_require.leader_confirm
      render_success("领投人确认成功")
    else
      render_fail(@money_require.errors.full_messages.to_s)
    end
  end

  # 关闭打开中的融资
  def close
    @project = @money_require.project
    if @money_require.close
      flash[:notice] = "关闭融资成功"
      render template: 'syndicates/syndicate_info', layout: false
    else
      render_fail(@money_require.errors.full_messages.to_s)
    end
  end

  def update
  end

  private
  def set_money_require
    @money_require = MoneyRequire.find( params[:id] )
  end
end
