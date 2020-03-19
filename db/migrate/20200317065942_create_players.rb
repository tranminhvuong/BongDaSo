class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :name, nul: false
      t.references :team
      t.string :position, nul: false, lengh: { maximum: 50 }
      t.integer :number, nul:false
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :players, :deleted_at
  end
end
