class ChangColumCategory < ActiveRecord::Migration[6.0]
  def up
    remove_column :posts, :category
    add_reference :posts, :category, index: true, default: 1
  end

  def down
    add_column :posts, :category, :string, null: false, default: 'Short new'
    remove_column :post, :category_id
  end
end
