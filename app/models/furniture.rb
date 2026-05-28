class Furniture < ApplicationRecord
  belongs_to :project
  belongs_to :chats
  has_one_attached :image
end
