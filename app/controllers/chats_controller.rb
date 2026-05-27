class ChatsController < ApplicationController
  def show
    @chat = Chat.find(params[:id])
    @messages = @chat.messages.order(:created_at)
    @message = Message.new
  end
end
