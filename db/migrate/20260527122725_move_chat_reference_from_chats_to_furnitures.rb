class MoveChatReferenceFromChatsToFurnitures < ActiveRecord::Migration[8.1]
  def change
    add_reference :furnitures, :chat, foreign_key: true
    remove_reference :chats, :furniture, foreign_key: true
  end
end
