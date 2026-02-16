class AddJoinActivityToTrips < ActiveRecord::Migration[7.1]
  def change
    add_column :trips, :join_activity, :boolean, default: true
  end
end
