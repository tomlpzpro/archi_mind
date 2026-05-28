class MessagesController < ApplicationController

  SYSTEM_PROMPT = "Vous êtes un assistant IA spécialisé en design d’intérieur et en visualisation d’espaces.\n\nAidez les architectes d’intérieur et designers à imaginer comment des meubles et objets décoratifs s’intègrent dans un espace.\n\nAnalysez le style, l’agencement, la lumière, les couleurs et l’ambiance de la pièce pour proposer des éléments cohérents de mobilier et de design.\n\nGénérez des réponses concises et visuellement descriptives, optimisées pour la génération d’images par IA.\n\nRépondez clairement en Markdown."
  # "You are a Teaching Assistant.\n\nI am a student at the Le Wagon AI Software Development Bootcamp, learning how to code.\n\nHelp me break down my problem into small, actionable steps, without giving away solutions.\n\nAnswer concisely in Markdown."

  def create
    @chat = Chat.find(params[:chat_id])
    @project = @chat.project

    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"

    if @message.save
      @ruby_llm_chat = RubyLLM.chat
      build_conversation_history
      response = @ruby_llm_chat.with_instructions(SYSTEM_PROMPT).ask(@message.content)
      Message.create(role: "assistant", content: response.content, chat: @chat)

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
