class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.references :player, presence: true
      t.references :match, presence: true
      t.references :type, presence: true
      t.string :time_at, null: false
    end
  end
end
