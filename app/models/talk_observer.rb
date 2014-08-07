class TalkObserver < ActiveRecord::Observer
  def after_create(talk)
    if talk.target_type == 'Project'
      ProjectTalkWorker.perform_async(talk.user_id, talk.target.id)
      project = talk.target
      user = project.owner
    elsif talk.target_type == 'MoneyRequire'
      LeadTalkWorker.perform_async(talk.user_id, talk.target.id)
      project = talk.target.project
      user = project.owner
    end

    Message.create(
      action: Message::TALK,
      user: user,
      project: project,
      target: talk,
    )
  end
end
