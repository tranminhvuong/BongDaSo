class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.string :name, null: false
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :roles, :deleted_at
  end
end
