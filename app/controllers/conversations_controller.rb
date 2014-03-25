# MessageBox 交谈
class ConversationsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @conversations = current_user.mailbox.conversations
  end

  def show
    conversation.mark_as_read current_user
  end

  def mark_as_read
    @conversation = Conversation.find( params[:id] )
    if @conversation.mark_as_read current_user
      render_success '已标记为已读'
    else
      render_fail
    end
  end

  def unread_count
    count = current_user.mailbox.conversations(unread: true).distinct.count
    render_success(nil, data: { count: count })
  end

end
