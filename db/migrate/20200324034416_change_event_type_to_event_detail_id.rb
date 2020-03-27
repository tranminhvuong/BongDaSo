class ChangeEventTypeToEventDetailId < ActiveRecord::Migration[6.0]
  def up
    remove_column :events, :event_type
    add_reference :events, :event_detail, index: true
  end

  def down
    add_column :events, :event_type, :string
    remove_column :events, :event_detail
  end
end
