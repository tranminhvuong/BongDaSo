class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.integer :turn
      t.string :place, length: { maximum: 255 }
      t.datetime :time
      t.integer :winner_id
      t.references :round
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :matches, :deleted_at
  end
end
