class MoneyRequiresController < ApplicationController
  before_action :set_money_require, only: [ :add_leader, :leader_confirm, :leader_reject, :close ]
  before_action :authenticate_user!, only: [ :admin ]

  def admin
    @project = Project.find( params[:project_id] )
    authorize! :update, @project
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
    @money_require = @project.opened_money_require
  end

  # 创建项目时使用, 取临时创建的需求
  def dirty_create
    @project = Project.find( params[:project_id] )
    authorize! :update, @project
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
    authorize! :update, @money_require
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
    @project = Project.find( params[:project_id] )
    authorize! :update, @project
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
    authorize! :update, @money_require
    leader_id = params[:leader_id]
    if @money_require.add_leader_and_wait_confirm(leader_id)
      render partial: 'money_require', locals: { money_require: @money_require }
    else
      render_fail(@money_require.errors.full_messages.to_s)
    end
  end

  def leader_reject
    authorize! :leader_confirm, @money_require
    if @money_require.leader_reject
      render "syndicates/create"
    else
      render_fail('拒绝失败', @money_require)
    end
  end

  def leader_confirm
    authorize! :leader_confirm, @money_require
    investment = Investment.new(money: params[:money])
    investment.user = current_user
    investment.money_require = @money_require
    if @money_require.leader_confirm_and_invest(investment, leader_word: params[:leader_word])
      render "syndicates/create"
    else
      render_fail('投资失败', investment)
    end
  end

  # 关闭打开中的融资
  def close
    authorize! :update, @money_require
    if @money_require.close
      render_success
    else
      render_fail(@money_require.errors.full_messages.to_s)
    end
  end

  def update
    @money_require = MoneyRequire.find( params[:id] )
    authorize! :update, @money_require
    if @money_require.update( money_require_params )
      @money_require.preheat! if @money_require.can_preheat?
      render_success
    else
      render_fail(nil, @money_require)
    end
  end

  private
  def set_money_require
    @money_require = MoneyRequire.find( params[:id] )
    @project = @money_require.project
  end

  def money_require_params
    money_require_params = params.permit(:money, :share, :description, :deadline, :maxnp)
  end
end
