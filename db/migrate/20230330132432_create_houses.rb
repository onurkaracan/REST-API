class CreateHouses < ActiveRecord::Migration[7.0]
  def change
    create_table :houses do |t|
      t.string :name
      t.string :description
      t.integer :max_guests
      t.text :amenities
      t.date :available_from
      t.date :available_to

      t.timestamps
    end
  end
end
