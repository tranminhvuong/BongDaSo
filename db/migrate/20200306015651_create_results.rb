class CreateResults < ActiveRecord::Migration[6.0]
  def change
    create_table :results do |t|
      t.references :team
      t.integer :goals_count
      t.integer :conceded_goals_count
      t.integer :score
      t.references :group
      t.datetime :deleted_at

      t.timestamps
    end 
    add_index :results, :deleted_at
  end
end
