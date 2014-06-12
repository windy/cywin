class PersonRequireObserver < ActiveRecord::Observer

  def after_create(person_require)
    event = Event.new(
      project_id: person_require.project_id,
      action: Event::PERSON_REQUIRE_CREATE,
      user_id: person_require.project.owner.try(:id),
    )
    event.target = person_require
    event.save
  end

end
