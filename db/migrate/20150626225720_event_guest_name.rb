class EventGuestName < ActiveRecord::Migration
  def change
  	add_column :schedule_events, :guest_name, :string
  end
end
