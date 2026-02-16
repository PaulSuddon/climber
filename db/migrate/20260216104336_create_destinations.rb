class CreateDestinations < ActiveRecord::Migration[7.1]
  def change
    create_table :destinations do |t|
      t.string :name
      t.text :description
      t.integer :activity_type
      t.decimal :latitude
      t.decimal :longitude
      t.string :difficulty_level
      t.string :address

      t.timestamps
    end
  end
end
