class RemoveColumnDescriptionsTournaments < ActiveRecord::Migration[6.0]
  def up
    remove_column :tournaments, :description
  end

  def down
    add_column :tournaments, :description, :string
  end
end
