class RemoveTimeZoneFromUser < ActiveRecord::Migration
  def change
  	remove_column :users, :tz_name
  end
end
