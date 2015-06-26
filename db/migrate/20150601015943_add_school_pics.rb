class AddSchoolPics < ActiveRecord::Migration
  def change
  	add_column :schools, :picture, :string
  end
end
