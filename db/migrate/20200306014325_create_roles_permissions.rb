class CreateRolesPermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :roles_permissions do |t|
      t.references :role
      t.references :permission
      t.datetime :deleted_at

      t.timestamps
    end 
    add_index :roles_permissions, :deleted_at
  end
end
