class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|
      t.string :name, length: { maximum: 255 }
      t.string :address, length: { maximum: 255 }
      t.datetime :deleted_at

      t.timestamps
    end 
    add_index :places, :deleted_at
  end
end
