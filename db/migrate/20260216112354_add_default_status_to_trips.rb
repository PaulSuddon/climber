class AddDefaultStatusToTrips < ActiveRecord::Migration[7.1]
  def change
    # Update any existing trips with nil status to 'open' (0)
    Trip.where(status: nil).update_all(status: 0)

    # Set default value for status column
    change_column_default :trips, :status, from: nil, to: 0
  end
end
