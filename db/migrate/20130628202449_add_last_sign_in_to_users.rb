class AddLastSignInToUsers < ActiveRecord::Migration
  def up
    add_column :users, :last_sign_in, :datetime
  end

  def down
    remove_column :users, :last_sign_in
  end
end
