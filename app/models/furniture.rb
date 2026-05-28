class Furniture < ApplicationRecord
  belongs_to :project
  belongs_to :chat
  has_one_attached :image
end
