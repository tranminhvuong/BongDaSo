class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false, length: { maximum: 255 }
      t.string :content, null: false, length: { maximum: 255 }
      t.boolean :status, default: false
      t.references :user
      t.string :category, null: false

      t.timestamps
    end
  end
end
