class ProjectObserver < ActiveRecord::Observer
  def after_save(project)
    #TODO 增加 Event 的处理
  end
end
