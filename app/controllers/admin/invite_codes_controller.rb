class Admin::InviteCodesController < Admin::ApplicationController
  def index
    @invite_codes = InviteCode.default_order
    @count = @invite_codes.count
    @used_count = @invite_codes.where(used: true).count
  end

  def new
  end

  def create
    if InviteCode.generate(params[:n].to_i)
      flash[:notice] = '生成成功'
      redirect_to admin_invite_codes_path
    else
      flash.now[:alert] = '生成失败, 系统最多支持 2000 个邀请码'
      render :new
    end
  end
end
