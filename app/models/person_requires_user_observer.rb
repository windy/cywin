class PersonRequiresUserObserver < ActiveRecord::Observer

  def after_create(person_requires_user)
    Event.create(
      user_id: person_requires_user.user_id,
      project_id: person_requires_user.person_require.project_id,
      action: Event::INTEREST_WORK,
      target: person_requires_user,
    )
  end

end
