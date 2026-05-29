require "base64"

class GenerateFurnitureImageTool < RubyLLM::Tool
  description "Génère et attache une image pour une furniture existante, à partir de son id."

  def initialize(furniture:)
    @furniture = furniture
  end

  def execute
    image = RubyLLM.paint("#{@furniture.title}. #{@furniture.description}", model: "gpt-image-1")

    @furniture.image.attach(
      io: StringIO.new(image.to_blob),
      filename: "furniture_#{@furniture.id}.png",
      content_type: image.mime_type || "image/png"
    )

    { status: "image_attached", furniture_id: @furniture.id, title: @furniture.title }
  rescue ActiveRecord::RecordNotFound
    { error: "Furniture not found" }
  rescue StandardError => e
    { error: e.message, furniture: @furniture }
  end
end

# Generate an image
# image = RubyLLM.paint("A photorealistic Le Wagon student coding in Ruby")
# puts image.url
# image.save("tmp/lewagon-student.png")
