class CreateRoundDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :round_details do |t|
      t.string :name, null: false
      t.string :round_type, null: false
      t.integer :num_of_teams
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :round_details, :deleted_at
  end
end
