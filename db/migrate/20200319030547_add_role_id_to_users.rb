class AddRoleIdToUsers < ActiveRecord::Migration[6.0]
  def up
    add_reference :users, :role, index: true
  end

  def down
    remove_column :users, :role_id
  end
end
