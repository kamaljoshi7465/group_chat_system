class CreateUserConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :user_conversations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group_conversation, null: false, foreign_key: true

      t.timestamps
    end
  end
end