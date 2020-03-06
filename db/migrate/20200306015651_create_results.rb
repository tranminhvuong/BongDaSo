class CreateResults < ActiveRecord::Migration[6.0]
  def change
    create_table :results do |t|
      t.references :team
      t.integer :goals_count
      t.integer :conceded_goals_count
      t.integer :score
      t.references :group
    end
  end
end
