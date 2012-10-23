class RemoveStationIdFromSongs < ActiveRecord::Migration
  def up
  	remove_column :songs, :station_id
  end

  def down
  	add_column :songs, :station_id, :integer
  end
end
