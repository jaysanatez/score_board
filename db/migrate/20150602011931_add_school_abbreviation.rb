class AddSchoolAbbreviation < ActiveRecord::Migration
  def change
  	add_column :schools, :abbreviation, :string
  end
end
