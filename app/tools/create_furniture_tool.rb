class CreateFurnitureTool < RubyLLM::Tool
  description "Creer une description qui permettra de creer un objet sur demande d'un architecte d'interieur"
  param :title, desc: "titre de la furniture"
  param :description, desc: "description de la furniture"

  def initialize(chat:)
    @chat = chat
  end

  def execute(title:, description:)
    @project = @chat.project
    furniture = Furniture.create!(
      title: title,
      description: description,
      project: @project,
      chat: @chat
    )
    { project_id: furniture.project.id, chat_id: furniture.chat.id, description: furniture.description,
      title: furniture.title }
  rescue ActiveRecord::RecordInvalid => e
    { error: e.message }
  end
end
