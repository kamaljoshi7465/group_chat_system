class AddMuteExpiryAndMuteDurationToUserConversations < ActiveRecord::Migration[7.0]
  def change
    add_column :user_conversations, :mute_expiry, :datetime
    add_column :user_conversations, :mute_duration, :integer
  end
end
