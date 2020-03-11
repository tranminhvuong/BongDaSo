class RenameColumnTournaments < ActiveRecord::Migration[6.0]
  def up
    rename_column :tournaments, :type, :rule
  end

  def down
    rename_column :tournaments, :rule, :type
  end
end
