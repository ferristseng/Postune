class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :activation_code
      t.integer :group_id
      t.boolean :is_active
      

      t.timestamps
    end
    add_index :users, :name, :unique => true
    add_index :users, :email, :unique => true
  end
end
