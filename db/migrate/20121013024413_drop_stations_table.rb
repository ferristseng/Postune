class DropStationsTable < ActiveRecord::Migration
  def up
  	drop_table :stations
  end

  def down

  end
end
