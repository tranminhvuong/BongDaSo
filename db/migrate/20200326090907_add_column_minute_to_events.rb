class AddColumnMinuteToEvents < ActiveRecord::Migration[6.0]
  def up
    add_column :events, :minute, :string, { null: false, default: '' }
  end

  def down
    remove_column :events, :minute
  end
end
