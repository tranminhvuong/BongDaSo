class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false, length: { maximum: 255 }
      t.text :content, null: false
      t.boolean :status, default: false
      t.references :user
      t.string :category, null: false
      t.datetime :deleted_at

      t.timestamps
    end
    
    add_index :posts, :deleted_at
  end
end
