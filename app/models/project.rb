class Project < ApplicationRecord
  belongs_to :user
  has_many :furnitures
  validates :title, presence: true
end
