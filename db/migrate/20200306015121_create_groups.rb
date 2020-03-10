class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.string :name, length: { maximum: 255 }
      t.references :tournament, presence: true
      t.datetime :deleted_at

      t.timestamps
    end 
    add_index :groups, :deleted_at
  end
end
