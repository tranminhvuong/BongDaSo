class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.references :tournament
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :teams, :deleted_at
  end
end
