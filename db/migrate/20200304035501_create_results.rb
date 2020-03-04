class CreateResults < ActiveRecord::Migration[6.0]
  def change
    create_table :results do |t|
      t.references :team, presence: true
      t.integer :goals_count
      t.integer :conceded_goals_count
      t.integer :score
      t.references :group, presence: true
    end
  end
end
