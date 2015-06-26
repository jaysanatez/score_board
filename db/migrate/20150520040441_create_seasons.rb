class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.belongs_to :sport, index: true
   	  t.belongs_to :school, index: true
      t.integer :year
      t.timestamps null: false
    end
  end
end
