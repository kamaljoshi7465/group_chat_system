class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :image
      t.string :full_name
      t.date :DOB
      t.integer :age
      t.integer :phone_number

      t.timestamps
    end
  end
end
