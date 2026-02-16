class AddDestinationFieldsToTrips < ActiveRecord::Migration[7.1]
  def change
    add_column :trips, :destination_name, :string
    add_column :trips, :destination_address, :string
    add_column :trips, :activity_type, :integer, default: 0

    # Make destination_id nullable
    change_column_null :trips, :destination_id, true
  end
end
