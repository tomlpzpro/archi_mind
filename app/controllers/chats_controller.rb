class ChatsController < ApplicationController
  def show
    @chat    = Chat.find(params[:id])
    @message = Message.new
  end

  def create
    @project = Project.find(params[:project_id])

    @chat = Chat.new(title: "Untitled")
    @chat.project = @project
    # @chat.user = current_user

    if @chat.save
      redirect_to chat_path(@chat)
    else
      # @chats = @project.chats.where(user: current_user)
      render "projects/show"
    end
  end
end
