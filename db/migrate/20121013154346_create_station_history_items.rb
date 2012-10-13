class CreateStationHistoryItems < ActiveRecord::Migration
  def change
    create_table :station_history_items do |t|
      t.integer :song_id
      t.datetime :played

      t.timestamps
    end
  end
end
