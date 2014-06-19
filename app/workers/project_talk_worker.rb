class ProjectTalkWorker
  include Sidekiq::Worker

  def perform(user_id, project_id)
    TalksMailer.project_talk(user_id, project_id).deliver
  end
end
