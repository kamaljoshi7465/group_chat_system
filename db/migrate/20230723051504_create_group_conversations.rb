class CreateGroupConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :group_conversations do |t|
      t.string :name
      t.string :icon
      t.text :description

      t.timestamps
    end

  end
end
