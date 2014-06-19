class MessagesController < ApplicationController

  before_action :authenticate_user!

  def index
    @messages = current_user.messages.default_order.page(params[:page])

    if params[:cond] == 'untreat'
      @messages = @messages.untreat
    elsif params[:cond] == 'treated'
      @messages = @messages.treated
    end

    @all = current_user.messages
    @count = @all.size
    @waiting_count = @all.untreat.size
  end

  def count
    render json: { count: current_user.messages.untreat.size }
  end

  after_action :mark_all_as_read, only: :index

  private
  def mark_all_as_read
    if current_user
      current_user.mark_all_as_read
    end
  end
end
