class CreateTournaments < ActiveRecord::Migration[6.0]
  def change
    create_table :tournaments do |t|
      t.string :name, null: false, length: { maximum: 255 }
      t.text :description
      t.integer :formula
      t.datetime :time_start
      t.datetime :time_end
      t.boolean :is_finish
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :tournaments, :deleted_at
  end
end
