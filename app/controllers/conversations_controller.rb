# MessageBox 交谈
class ConversationsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @conversations = current_user.mailbox.conversations
  end

  def show
    conversation.mark_as_read current_user
  end

end
