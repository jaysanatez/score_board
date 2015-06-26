class CreateEventRevisions < ActiveRecord::Migration
  def change
    create_table :event_revisions do |t|
      t.belongs_to :schedule_event, index: true
	  t.integer :home_score
      t.integer :away_score
      t.integer :status
      t.integer :period
      t.timestamps null: false
    end
  end
end
