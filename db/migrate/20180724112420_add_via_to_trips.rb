class AddViaToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :via, :string
  end
end
