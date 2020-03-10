class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :name, null: false, length: { maximum: 50 }
      t.string :address, null: false, length: { maximum: 255 }
      t.date :date_of_birth
      t.references :team
      t.string :avatar, length: { maximum: 255 }
      t.string :position, length: { maximum: 50 } 
      t.datetime :deleted_at

      t.timestamps
    end 
    add_index :players, :deleted_at
  end
end
