class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|
      t.string :name, length: { maximum: 255}
      t.string :address, length: { maximum: 255}
    end
  end
end
