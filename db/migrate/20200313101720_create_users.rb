class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, length: { maximum: 50 }
      t.string :email, unique: true
      t.string :password_digest
      t.string :remember_digest
      t.string :reset_digest
      t.datetime :reset_send_at
      t.datetime :deleted_at
    
      t.timestamps
    end
    add_index :users, :deleted_at
  end
end
