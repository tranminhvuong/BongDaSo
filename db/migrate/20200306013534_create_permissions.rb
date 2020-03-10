class CreatePermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :permissions do |t|
      t.string :permission, null: false, default: ""
      t.datetime :deleted_at
    
      t.timestamps
    end
    add_index :permissions, :deleted_at
  end
end
