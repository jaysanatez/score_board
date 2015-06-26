class ScheduleEvent < ActiveRecord::Base
	validates :home_season_id, presence: true 
	validates :away_season_id, presence: true 

	attr_accessor :home_season
	attr_accessor :away_season
end

# status: 0 - not started, 1 - in progress, 2 - completed, 3 - postponed
# period: 1,2,4,5 - each period, 3- half, 6 - overtime