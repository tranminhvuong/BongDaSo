class RemoveColumnGroupTotalFromTournaments < ActiveRecord::Migration[6.0]
  def up
    remove_column :tournaments, :groups_total
  end

  def down
    add_column :tournaments, :groups_total, :integer, null: false
  end
end
