class MakePathTextColumn < ActiveRecord::Migration
  def up
  	change_column :songs, :path, :text
  end

  def down
  	change_column :songs, :path, :string
  end
end
