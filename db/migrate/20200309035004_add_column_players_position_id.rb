class AddColumnPlayersPositionId < ActiveRecord::Migration[6.0]
  def up
    add_reference :players, :position, foreign_key: true
  end

  def down
    remove_column :players, :position_id
  end
end
