class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.references :players, presence: true
      t.references :matches, presence: true
      t.references :types, presence: true
      t.string :time_at, null: false
    end
  end
end
