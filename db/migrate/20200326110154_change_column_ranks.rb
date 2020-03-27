class ChangeColumnRanks < ActiveRecord::Migration[6.0]
  def up
    change_column :ranks, :goals_for, :integer, { null: false, default: 0 }
    change_column :ranks, :goals_against, :integer, { null: false, default: 0 }
    change_column :ranks, :win, :integer, { null: false, default: 0 }
    change_column :ranks, :lose, :integer, { null: false, default: 0 }
    change_column :ranks, :draw, :integer, { null: false, default: 0 }
    change_column :ranks, :score, :integer, { null: false, default: 0 }
  end

  def down
    change_column :ranks, :goals_for, :integer
    change_column :ranks, :goals_against, :integer
    change_column :ranks, :win, :integer
    change_column :ranks, :lose, :integer
    change_column :ranks, :draw, :integer
    change_column :ranks, :score, :integer
  end
end