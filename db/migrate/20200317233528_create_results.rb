class CreateResults < ActiveRecord::Migration[6.0]
  def change
    create_table :results do |t|
      t.references :team
      t.references :match
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :results, :deleted_at
  end
end
