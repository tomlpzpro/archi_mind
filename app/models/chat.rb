class Chat < ApplicationRecord
  belongs_to :project
  has_one :user, through: :project
  has_one :furniture
  has_many :messages, dependent: :destroy
end
