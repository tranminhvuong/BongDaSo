class CreatePermisions < ActiveRecord::Migration[6.0]
  def change
    create_table :permisions do |t|
      t.string :permision, null: false, default: ""
      t.references :role, precense: true
    end
  end
end
