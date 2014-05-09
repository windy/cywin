class MessagesController < ApplicationController
  before_action :authenticate_user!
  def index
    @messages = current_user.messages
    @count = @messages.size
    @waiting_count = @messages.untreat.size
  end
end
