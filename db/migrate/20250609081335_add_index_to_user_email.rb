class AddIndexToUserEmail < ActiveRecord::Migration[8.0]
  def change
    add_index :user, :email, unique: true
  end
end
