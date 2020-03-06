class CreateRolesPermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :roles_permissions do |t|
      t.references :role
      t.references :permission
    end
  end
end
