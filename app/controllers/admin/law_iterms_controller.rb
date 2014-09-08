class Admin::LawItermsController < Admin::ApplicationController
  def index
    @law_iterms = LawIterm.all
  end

  def new
    @law_iterm = LawIterm.new
  end

  def create
    @law_iterm = LawIterm.new( law_iterm_params )
    if @law_iterm.save
      flash[:notice] = '创建成功'
      redirect_to admin_law_iterms_path
    else
      render :new
    end
  end

  private
  def law_iterm_params
    params.require(:law_iterm).permit(:title, :description, :public)
  end
end
