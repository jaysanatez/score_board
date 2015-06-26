class EventsController < ApplicationController
	def index
	    @event = ScheduleEvent.find(params[:id])
	    @event.home_season = Season.find(@event.home_season_id)
	    @event.away_season = Season.find(@event.away_season_id)
	    away_school = @event.away_season.school
	    home_school = @event.home_season.school
	    tz = ActiveSupport::TimeZone.new(home_school.tz_name)
	    @date = @event.date.in_time_zone(tz) # convert that date to home team's local time
	    @updated_at = @event.updated_at.in_time_zone(tz)
	    @away_display = "#{away_school.name};#{away_school.abbreviation}"
	    @home_display = "#{home_school.name};#{home_school.abbreviation}"

	    @away_winner = @event.status == 2 && @event.away_score > @event.home_score
	    @home_winner = @event.status == 2 && @event.home_score > @event.away_score

	    @source_season_id = params[:season_id]

	    if @event.status == 1
	      case @event.period
	        when 1
	          @period_display = "1st"
	        when 2
	          @period_display = "2nd"
	        when 3
	          @period_display = "Half"
	        when 4
	          @period_display = "3rd"
	        when 5
	          @period_display = "4th"
	        when 6
	          @period_display = "OT"
	      end
	    elsif @event.status == 2
	      if @event.period == 6
	        @period_display = "Final/OT"
	      else
	        @period_display = "Final"
	      end
	    elsif @event.status == 3
	      @period_display = "Postponed"
	    else
	      @period_display = ""
	    end

	    @revisions = EventRevision.where(:schedule_event_id => @event.id).order(created_at: :desc)

	    @zones = { }
	    @revisions.each do |r|
	   		@zones[r.id] = r.created_at.in_time_zone(tz)
	    end

	    # edit options
	    @statuses = [ SelectItem.new(0, "Future"), SelectItem.new(1, "In Progress"),SelectItem.new(2, "Finished"), SelectItem.new(3, "Postponed") ]
	    @periods = [ SelectItem.new(1, "1st"), SelectItem.new(2, "2nd"), SelectItem.new(3, "Halftime"), SelectItem.new(4, "3rd"), SelectItem.new(5, "4th"), SelectItem.new(6, "Overtime") ]

	    season = Season.find(@source_season_id)
	    opp_name = if season.id == @event.home_season_id then @event.away_season.school.name else @event.home_season.school.name end
	    @prms = { "school" => season.school.name, "sport" => season.sport.to_string, "year" => season.year, "opponent" => "vs. #{opp_name}" }
	    render :layout => "borderless"
  	end

  	def create
	    if school_admin?(params[:school_id])
	    	d = params[:event]
	    	osi = d[:opp_season_id]
	      	if osi == null || osi != ""
	      	else
	      		b = d[:home] == "1"
	      		home_id = if b then params[:season_id] else osi end
	      		away_id = if b then osi else params[:season_id] end
	      		dt = DateTime.new(d["date(1i)"].to_i, d["date(2i)"].to_i, d["date(3i)"].to_i, d["date(4i)"].to_i, d["date(5i)"].to_i, 0)
	      		s = School.find(params[:school_id])
	      		dt = ActiveSupport::TimeZone.new(s.tz_name).local_to_utc(dt)
	      		ScheduleEvent.create(:home_season_id => home_id, :away_season_id => away_id, :home_score => 0, :away_score => 0, :status => 0, :period => 0, :date => dt)
	      	end
	    end

	    redirect_to :controller => :seasons, :action => :index, :id => params[:season_id]
	end

	def update
		p = params[:event]
		if params[:id]
			event = ScheduleEvent.find(params[:id])
			hs = Season.find(event.home_season_id)
			dt = DateTime.new(p["date(1i)"].to_i, p["date(2i)"].to_i, p["date(3i)"].to_i, p["date(4i)"].to_i, p["date(5i)"].to_i, 0)
			dt = ActiveSupport::TimeZone.new(hs.school.tz_name).local_to_utc(dt)
			
			a_s = p[:away_score]
			h_s = p[:home_score]
			pe = p[:period]
			st = p[:status]

			event.update(:away_score => a_s, :home_score => h_s, :period => pe, :status => st, :date => dt)
	    	
			if EventRevision.where(:schedule_event_id => event.id, :away_score => a_s, :home_score => h_s, :period => pe, :status => st).count == 0
	    		EventRevision.create(:schedule_event_id => event.id, :away_score => a_s, :home_score => h_s, :period => pe, :status => st)
	    	end

			if params[:swap]
				h_sc = event.home_score
				event.home_score = event.away_score
				event.away_score = h_sc

				h_id = event.home_season_id
				event.home_season_id = event.away_season_id
				event.away_season_id = h_id

				event.save
			end
	    end

	    sleep(1)
	    redirect_to :action => :index, :id => event.id, :season_id => params[:season_id]
	end

	def delete
	    if params[:id]
	    	event = ScheduleEvent.find(params[:id])
	    end

	    if event
	    	# event.destroy
	    end

	    redirect_to :controller => :seasons, :action => :index, :id => params[:season_id]
	end
end