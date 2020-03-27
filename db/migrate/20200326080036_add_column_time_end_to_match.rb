class AddColumnTimeEndToMatch < ActiveRecord::Migration[6.0]
  def up
    add_column :matches, :time_end, :datetime
  end

  def down
    remove_column :matches, :time_end
  end
end
