class CreateResetTokens < ActiveRecord::Migration
  def change
    create_table :reset_tokens do |t|
      t.integer :user_id
      t.string :reset_token, :unique => true
      t.datetime :expires

      t.timestamps
    end
  end
end
