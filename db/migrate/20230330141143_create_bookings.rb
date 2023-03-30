class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.references :house, null: false, foreign_key: true
      t.string :name
      t.date :from
      t.date :to

      t.timestamps
    end
  end
end
