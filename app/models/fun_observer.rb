class FunObserver < ActiveRecord::Observer
  def after_create(fun)
    event = Event.new
    event.user = fun.user
    event.target = User.find(fun.interested_user_id)
    event.action = Event::USER_FUN
    event.save!
  end
end
