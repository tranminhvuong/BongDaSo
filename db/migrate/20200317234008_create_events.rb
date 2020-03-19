class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.references :result
      t.references :player
      t.string :event_type
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :events, :deleted_at
  end
end
