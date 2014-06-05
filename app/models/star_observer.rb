class StarObserver < ActiveRecord::Observer
  def after_create(star)
    Event.create(
      project_id: star.project_id, 
      action: Event::PROJECT_STAR,
      user_id: star.user_id
    )
  end
end
