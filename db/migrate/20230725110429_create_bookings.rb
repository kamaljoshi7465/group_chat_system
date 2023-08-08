class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.references :property, null: false, foreign_key: true
      t.references :meeting_room, null: false, foreign_key: true
      t.references :seat, null: false, foreign_key: true
      t.datetime :booking_date
      t.string :time_slot
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
