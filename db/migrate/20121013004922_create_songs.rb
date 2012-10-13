class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :path
      t.string :title
      t.string :artist
      t.string :album
      t.string :artwork
      t.integer :user_id
      t.integer :station_id

      t.timestamps
    end
  end
end
