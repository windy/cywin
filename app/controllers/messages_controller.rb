class MessagesController < ApplicationController
  before_action :authenticate_user!
  def index
    @messages = current_user.messages.default_order
    @count = @messages.size
    @waiting_count = @messages.untreat.size
  end
end
