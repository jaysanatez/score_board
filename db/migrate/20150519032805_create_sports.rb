class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|
      t.string :name
      t.boolean :male
      t.timestamps null: false
    end

    create_table :schools do |t|
      t.string :name
      t.timestamps null: false
    end

    create_table :teams do |t|
   	  t.belongs_to :sport, index: true
   	  t.belongs_to :school, index: true
      t.timestamps null: false
    end
  end
end
