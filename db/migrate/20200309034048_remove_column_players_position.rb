class RemoveColumnPlayersPosition < ActiveRecord::Migration[6.0]
  def up
    remove_column :players, :position
  end

  def down
    add_column :players, :position, :string
  end
end
