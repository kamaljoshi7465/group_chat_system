class User < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :group_conversations, through: :user_conversation
  has_many :user_conversation, dependent: :destroy
  has_many :bookings, dependent: :destroy
  
  validates :full_name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  def self.ransackable_attributes(auth_object = nil)
    ["DOB", "age", "created_at", "email", "encrypted_password", "first_name", "full_name", "id", "image", "last_name", "phone_number", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["bookings", "group_conversations", "messages", "user_conversation"]
  end
end
