class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :name
      t.string :description
      t.integer :user_id
      t.string :slug

      t.timestamps
    end
  end
end
