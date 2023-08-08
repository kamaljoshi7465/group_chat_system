class CreateMeetingRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :meeting_rooms do |t|
      t.string :name
      t.string :capacity
      t.string :booking_status
      t.references :property, null: false, foreign_key: true

      t.timestamps
    end
  end
end
