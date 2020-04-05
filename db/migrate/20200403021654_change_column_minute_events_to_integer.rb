class ChangeColumnMinuteEventsToInteger < ActiveRecord::Migration[6.0]
  def up
    remove_column :events, :minute
    add_column :events, :minute, :integer
  end

  def down
    remove_column :events, :minute
    add_column :events, :minute, :string
  end
end
