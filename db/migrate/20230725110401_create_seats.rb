class CreateSeats < ActiveRecord::Migration[7.0]
  def change
    create_table :seats do |t|
      t.string :capacity
      t.string :seat_name
      t.string :booking_status
      t.references :property, null: false, foreign_key: true

      t.timestamps
    end
  end
end
