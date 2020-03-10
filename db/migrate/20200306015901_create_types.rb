class CreateTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :types do |t|
      t.string :name
      t.datetime :deleted_at

      t.timestamps
    end 
    add_index :types, :deleted_at
  end
end
