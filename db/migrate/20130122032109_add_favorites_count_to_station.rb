class AddFavoritesCountToStation < ActiveRecord::Migration
  def up
  	add_column :stations, :favorites_count, :integer, :default => 0, :null => false

		Station.reset_column_information

		Station.all.each do |s|
		  Station.update_counters s.id, :favorites_count => s.favorites.length
		end
  end

  def down
  	drop_column :stations, :favorites_count
  end
end
