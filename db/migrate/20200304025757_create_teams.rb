class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.integer :manager_id, class_name: User.name
      t.integer :tournament_id, class_name: Tournament.name
      t.string :logo, default: "", length: { maximum: 255 }
    end
  end
end
