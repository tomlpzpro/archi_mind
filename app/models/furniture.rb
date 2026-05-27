class Furniture < ApplicationRecord
  belongs_to :project
  has_many :chats, dependent: :destroy
end
