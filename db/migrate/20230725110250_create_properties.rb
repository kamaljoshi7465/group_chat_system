class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.string :name
      t.text :description
      t.string :property_type
      t.string :country
      t.string :latitude
      t.string :longitude
      t.string :address
      t.string :location_link
      t.text :amenities
      t.json :floor_plan_images
      t.json :property_images

      t.timestamps
    end
  end
end
