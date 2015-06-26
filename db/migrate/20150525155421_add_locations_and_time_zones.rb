class AddLocationsAndTimeZones < ActiveRecord::Migration
  def change
  	add_column :schools, :location, :string
  	add_column :schools, :tz_name, :string
  	add_column :users, :tz_name, :string
  end
end
