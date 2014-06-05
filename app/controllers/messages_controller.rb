class MessagesController < ApplicationController
  before_action :authenticate_user!
  def index
    @messages = current_user.messages.default_order.page(params[:page])
    @all = current_user.messages
    @count = @all.size
    @waiting_count = @all.untreat.size
  end
end
