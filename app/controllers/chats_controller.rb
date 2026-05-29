class ChatsController < ApplicationController
  def show
    @chat    = Chat.find(params[:id])
    @message = Message.new
  end

  def create
    @project = Project.find(params[:project_id])

    # on crée une discussion sans titre (l'utilisateur le saisira sur la page du chat)
    @chat = Chat.new(title: Chat::DEFAULT_TITLE)
    @chat.project = @project
    @chat.user = current_user

    if @chat.save
      redirect_to chat_path(@chat)
    else
      # @chats = @project.chats.where(user: current_user)
      puts @chat.errors.full_messages
      render "projects/show"
    end
  end

  # # PATCH /chats/:id → met à jour le titre de la discussion
  # def update
  #   # on retrouve la discussion
  #   @chat = Chat.find(params[:id])
  #   # on enregistre le nouveau titre saisi dans le formulaire
  #   @chat.update(chat_params)
  #   # on revient sur la page de la discussion
  #   redirect_to chat_path(@chat)
  # end

  # DELETE /chats/:id → supprime une discussion
  def destroy
    # on retrouve la discussion
    @chat = Chat.find(params[:id])
    # on garde le projet en mémoire pour pouvoir y revenir après
    projet = @chat.project
    # on supprime la discussion
    @chat.destroy
    # on revient à la page du projet en gardant le mode suppression actif
    redirect_to project_path(projet, suppression: 1)
  end

#   private

#   # on autorise uniquement le champ "title" venant du formulaire
#   def chat_params
#     params.require(:chat).permit(:title)
#   end
end
