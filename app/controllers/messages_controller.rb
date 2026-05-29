class MessagesController < ApplicationController
  SYSTEM_PROMPT = <<~PROMPT
    Vous êtes un assistant IA spécialisé en design d'intérieur et en visualisation d'espaces.

    Aidez les architectes d'intérieur et designers à imaginer comment des meubles et objets décoratifs s'intègrent dans un espace.

    Analysez le style, l'agencement, la lumière, les couleurs et l'ambiance de la pièce pour proposer des éléments cohérents de mobilier et de design.

    Vous avez accès à des outils :
    - Créez un meuble (furniture) avec un titre et une description quand l'architecte demande une suggestion de mobilier pour son projet. Ne créez qu'un seul meuble à la fois, sauf demande explicite.
    - Génère une image pour un meuble après l'avoir créé, en utilisant son id.
    Générez des réponses concises et visuellement descriptives, optimisées pour la génération d'images par IA. Quand tu genere l'image, affiche la directement dans la conversation sans que l'utilisateur ai besoin de le demander.

    Répondez clairement en texte.
  PROMPT

  def create
    @chat = Chat.find(params[:chat_id])
    @project = @chat.project

    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"

    if @message.save
      @ruby_llm_chat = RubyLLM.chat
      build_conversation_history
      @ruby_llm_chat.with_tool(CreateFurnitureTool.new(chat: @chat))
      @ruby_llm_chat.with_tool(GenerateFurnitureImageTool.new(furniture: @chat.furniture))
      response = @ruby_llm_chat.with_instructions(SYSTEM_PROMPT).ask(@message.content)
      Message.create(role: "assistant", content: response.content, chat: @chat)

      @chat.generate_title_from_first_message

      redirect_to chat_path(@chat)
    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def build_conversation_history
    @chat.messages.each do |message|
      @ruby_llm_chat.add_message(
        role: message.role,
        content: message.content
      )
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
