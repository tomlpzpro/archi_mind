class Chat < ApplicationRecord
  belongs_to :project
  belongs_to :furniture
  has_many :messages, dependent: :destroy
end
