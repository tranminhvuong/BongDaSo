class AddColumnGoalsToResults < ActiveRecord::Migration[6.0]
  def up
    add_column :results, :goals, :integer, default: 0
  end

  def down
    remove_column :results, :goals
  end
end
