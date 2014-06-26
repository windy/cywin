# 精品项目显示
class RefineController < ApplicationController

  def index
    @recommends = Recommend.all.default_order.includes(:project)
  end

end
