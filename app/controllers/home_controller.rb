class HomeController < ApplicationController
	def index
		if logged_in? && current_user.role == 1 # if team admin
			@school = School.find(current_user.school_id)
		end

		@current_date_string = DateTime.now.strftime("%B %e")

		@tz = ActiveSupport::TimeZone.new("Eastern Time (US & Canada)")
		@games = ScheduleEvent.all.select { |e| @tz.utc_to_local(e.date).to_date == DateTime.now.to_date }.sort_by { |e| e.date }

		@games.each do |g|
			g.home_season = Season.find(g.home_season_id)
	    	g.away_season = Season.find(g.away_season_id)
		end

		render :layout => 'borderless'
	end
end