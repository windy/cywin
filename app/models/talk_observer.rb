class TalkObserver < ActiveRecord::Observer
  def after_create(talk)
    if talk.target_type == 'Project'
      ProjectTalkWorker.perform_async(talk.user_id, talk.target.id)
    elsif talk.target_type == 'MoneyRequire'
      LeadTalkWorker.perform_async(talk.user_id, talk.target.id)
    end
  end
end
