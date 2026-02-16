class ChangeActivityTypeToStringInTrips < ActiveRecord::Migration[7.1]
  def change
    change_column :trips, :activity_type, :string, default: "climbing"
  end
end
