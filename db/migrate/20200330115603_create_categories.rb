class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.datetime :deleted_at
      
      t.timestamps
    end
    add_index :categories, :deleted_at
  end
end
