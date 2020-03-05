class RemoveColumnUsersRoleId < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :role_id
    add_column :roles, :user_id, :integer
    add_foreign_key :roles, :users, column: :user_id, primary_key: "id"
  end

  def down
    add_column :users, :role_id, :integer
    add_foreign_key :users, :roles, column: :role_id, primary_key: "id"
    remove_column :roles, :user_id
  end
end
