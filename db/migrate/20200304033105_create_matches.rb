class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.references :place, presence: true
      t.datetime :time
      t.references :group, presence: true
      t.boolean :type, null: false, default: false
    end
  end
end
