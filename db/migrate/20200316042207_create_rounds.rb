class CreateRounds < ActiveRecord::Migration[6.0]
  def change
    create_table :rounds do |t|
      t.references :tournament
      t.string :name, null: false
      t.boolean :is_return, null: false
      t.references :round_detail
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :rounds, :deleted_at
  end
end
