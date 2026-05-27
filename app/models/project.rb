class Project < ApplicationRecord
  belongs_to :user
  has_many :furnitures, dependent: :destroy
  has_many :chats, dependent: :destroy
  validates :title, presence: true
end
