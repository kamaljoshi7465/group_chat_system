class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group_conversation  

  validates :body, presence: true
end