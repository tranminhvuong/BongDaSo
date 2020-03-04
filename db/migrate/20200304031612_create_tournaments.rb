class CreateTournaments < ActiveRecord::Migration[6.0]
  def change
    create_table :tournaments do |t|
      t.string :name, null: false, default: ""
      t.integer :teams_total, null: false, default: 0
      t.integer :groups_total, null: false, default: 0
      t.datetime :time_register
      t.datetime :time_start
      t.datetime :time_end
      t.boolean :type, null: false, default: false
      t.boolean :turn_back, null: false, default: false
    end
  end
end
