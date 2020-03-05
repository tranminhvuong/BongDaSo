class CreateRolesPermisions < ActiveRecord::Migration[6.0]
  def change
    create_table :roles_permisions do |t|
      t.references :role
      t.references :permision
    end
  end
end
