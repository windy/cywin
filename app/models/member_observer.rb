class MemberObserver < ActiveRecord::Observer
  def after_create(member)
    Event.create(
      user_id: member.user_id,
      project_id: member.project_id,
      action: Event::PROJECT_JOIN,
      data: {
        role: member.role,
        priv: member.priv,
      }
    )
  end
end
