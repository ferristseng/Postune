class CreateStations < ActiveRecord::Migration
  def change
  	drop_table :stations
    create_table :stations do |t|
      t.string :name
      t.string :permalink
      t.integer :user_id

      t.timestamps
    end
  end
end
