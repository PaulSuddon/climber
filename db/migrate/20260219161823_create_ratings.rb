class CreateRatings < ActiveRecord::Migration[7.1]
  def change
    create_table :ratings do |t|
      t.references :trip, null: false, foreign_key: true
      t.references :reviewer, null: false, foreign_key: { to_table: :users }
      t.references :rated_user, null: false, foreign_key: { to_table: :users }
      t.integer :rating, null: false
      t.text :comment

      t.timestamps
    end

    # Prevent duplicate ratings (one rating per reviewer per trip per rated_user)
    add_index :ratings, [:trip_id, :reviewer_id, :rated_user_id], unique: true
  end
end
