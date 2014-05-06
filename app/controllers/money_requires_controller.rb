class MoneyRequiresController < ApplicationController
  before_action :set_money_require, only: [ :add_leader, :leader_confirm, :close ]

  def admin
    @project = Project.find( params[:project_id] )
  end

  def opened
    @project = Project.find( params[:project_id] )
    @money_require = @project.opened_money_require
  end

  def history
    @project = Project.find( params[:project_id] )
    @money_requires = @project.history_money_requires
  end

  # 创建项目时使用, 取临时创建的需求
  def dirty_show
    @project = Project.find( params[:project_id] )
    money_require = MoneyRequire.where(status: :ready, project_id: @project.id).first
    if money_require
      render_success(nil, data: {
        money: money_require.money,
        share: money_require.share,
        id: money_require.id,
      })
    else
      render_fail
    end
  end

  # 创建项目时使用, 取临时创建的需求
  def dirty_create
    @project = Project.find( params[:project_id] )
    authorize! :update, @project
    money_require_params = params.permit(:money, :share)
    @money_require = MoneyRequire.new(money_require_params)
    @money_require.project = @project
    if @money_require.save(validate: false)
      render_success
    else
      render_fail(@money_require.errors.full_messages.to_s)
    end
  end

  def dirty_update
    @money_require = MoneyRequire.find( params[:id] )
    @project = @money_require.project
    authorize! :update, @project
    @money_require.money = params[:money]
    @money_require.share = params[:share]
    if @money_require.save(validate: false)
      render_success
    else
      render_fail(@money_require.errors.full_messages.to_s)
    end
  end

  # 发起一个新的融资
  def create
    authorize! :update, @project
    @project = Project.find( params[:project_id] )
    money_require_params = params.permit(:money, :share, :description, :deadline)
    @money_require = MoneyRequire.new(money_require_params)
    @money_require.project = @project
    if @money_require.save
      @money_require.preheat!
      render_success
    else
      render_fail(nil, @money_require)
    end
  end

  # 添加一个领投人, 并等待确认
  def add_leader
    leader_id = params.require(:money_require).permit(:leader_id)[:leader_id]
    if @money_require.add_leader_and_wait_confirm(leader_id)
      render template: 'syndicates/syndicate_info', layout: false
    else
      render_fail(@money_require.errors.full_messages.to_s)
    end
  end

  def leader_confirm
    if @money_require.leader_confirm
      render template: 'syndicates/invest', layout: false
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
    @money_require = MoneyRequire.find( params[:id] )
    @project = @money_require.project
    authorize! :update, @project
    if @money_require.update( money_require_params )
      render_success
    else
      render_fail(@money_require.errors.full_messages.to_s)
    end
  end

  private
  def set_money_require
    @money_require = MoneyRequire.find( params[:id] )
    @project = @money_require.project
  end

  def money_require_params
    money_require_params = params.require(:money_require).permit(:money, :share, :description, :deadline, :project_id)
  end
end
