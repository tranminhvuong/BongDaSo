class RemoveColumnRoles < ActiveRecord::Migration[6.0]
  def up
    remove_column :permisions, :role_id
  end

  def down
    add_column :permisions, :role_id, :integer
    add_foreign_key :permisions, :roles, column: :role_id, primary_key: "id"
  end
end
