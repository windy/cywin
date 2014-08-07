class LeadTalkWorker
  include Sidekiq::Worker

  def perform(user_id, money_require_id)
    TalksMailer.lead_talk(user_id, money_require_id).deliver
  end
end
