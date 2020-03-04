class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.string :name, length: { maximum: 255 }
      t.references :tournaments, presence: true
    end
  end
end
