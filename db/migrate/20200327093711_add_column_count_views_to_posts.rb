class AddColumnCountViewsToPosts < ActiveRecord::Migration[6.0]
  def up
    add_column :posts, :count_views, :integer, { default: 0 }
  end

  def down
    remove_column :posts, :count_views
  end
end
