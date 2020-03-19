class CreateRanks < ActiveRecord::Migration[6.0]
  def change
    create_table :ranks do |t|
      t.references :team
      t.references :round
      t.integer :goals_for
      t.integer :goals_against
      t.integer :win
      t.integer :lose
      t.integer :draw
      t.integer :score
      t.datetime :deleted_at
      
      t.timestamps
    end
    add_index :ranks, :deleted_at
  end
end
