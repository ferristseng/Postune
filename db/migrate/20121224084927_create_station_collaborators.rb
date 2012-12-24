class CreateStationCollaborators < ActiveRecord::Migration
  def change
    create_table :station_collaborators do |t|
      t.integer :user_id
      t.integer :station_id
      t.string :title

      t.timestamps
    end
  end
end
