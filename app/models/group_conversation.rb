class GroupConversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :user_conversations, dependent: :destroy
  has_many :users, through: :user_conversations 

  validates :name, presence: true
  validate :validate_user_ids
  attr_accessor :include_messages

  def add_users(user_ids)
    user_ids.each do |user_id|
      user_conversations.create(user_id: user_id)
    end
  end
   
  private
  def validate_user_ids
    if user_ids.blank? || !user_ids.all? { |id| id.is_a?(Integer) && User.exists?(id) }
      errors.add(:user_ids, "must be an array of valid user IDs")
    elsif user_ids.size < 2 
      errors.add(:user_ids, "must have at least two members")
    end
  end
end