class CreateEventDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :event_details do |t|
      t.string :name
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :event_details, :deleted_at
  end
end
