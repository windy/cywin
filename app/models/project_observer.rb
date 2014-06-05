class ProjectObserver < ActiveRecord::Observer
  def after_create(project)
    Event.create(
      project_id: project.id,
      action: Event::PROJECT_CREATE,
      user_id: project.owner.try(:id)
    )
  end
  
  def after_update(project)
    Event.create(
      project_id: project.id,
      action: Event::PROJECT_UPDATE,
      user_id: project.owner.try(:id)
    )
  end
end
