class ChangeFavoriteTableNameToUserStationFavorite < ActiveRecord::Migration
  def up
  	rename_table :favorites, :user_station_favorites
  end

  def down
  	rename_table :user_station_favorites, :favorites
  end
end
