class CreateTrips < ActiveRecord::Migration[7.1]
  def change
    create_table :trips do |t|
      t.references :user, null: false, foreign_key: true
      t.references :destination, null: false, foreign_key: true
      t.datetime :departure_date
      t.string :departure_location
      t.integer :available_seats
      t.decimal :price_per_seat
      t.text :description
      t.integer :status

      t.timestamps
    end
  end
end
