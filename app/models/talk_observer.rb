class TalkObserver < ActiveRecord::Observer
  def after_create(talk)
    if talk.target_type == 'Project'
      ProjectTalkWorker.perform_async(talk.user_id, talk.target.id)
    else
      # TODO
    end
  end
end
