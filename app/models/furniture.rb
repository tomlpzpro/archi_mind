class Furniture < ApplicationRecord
  belongs_to :project
  belongs_to :chat
end
