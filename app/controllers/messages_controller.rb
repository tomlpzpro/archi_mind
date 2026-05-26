class MessagesController < ApplicationController
  def create
    @chat = Chat.find(params[:chat_id])

    # 1. Crée le message du user avec le contenu du form
    @chat.messages.create!(message_params.merge(role: "user"))

    # 2. Fake la réponse de l'IA (à remplacer plus tard par un vrai appel API)
    @chat.messages.create!(
      title: "Voici une suggestion pour ton projet : un meuble qui correspond à ton brief.",
      role: "assistant"
    )

    # 3. Redirige vers la page du chat pour voir les nouveaux messages
    redirect_to chat_path(@chat)
  end

  private

  def message_params
    params.require(:message).permit(:title)
  end
end
