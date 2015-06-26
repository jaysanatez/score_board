class CreateScheduleEvents < ActiveRecord::Migration
  def change
    create_table :schedule_events do |t|
      t.integer :home_season_id
      t.integer :away_season_id
      t.integer :home_score
      t.integer :away_score
      t.integer :status
      t.integer :period
      t.datetime :date
      t.timestamps null: false
    end
  end
end
