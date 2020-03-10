class RemoveLogoOfTeams < ActiveRecord::Migration[6.0]
  def up
    remove_column :teams, :logo
  end

  def down
    add_column :teams, :logo, :string
  end
end
