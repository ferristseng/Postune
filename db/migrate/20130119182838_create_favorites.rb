class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :station_id
      t.boolean :favorite

      t.timestamps
    end
  end
end
