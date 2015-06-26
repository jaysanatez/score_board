class SeasonsController < ApplicationController
  def index
  	@season = Season.find(params[:id])
  	@schedule_events = ScheduleEvent.where("home_season_id = (?) or away_season_id = (?)", @season.id, @season.id).sort_by { |e| e.date }
  	
    seasons = Season.where(:school_id => @season.school_id, :sport_id => @season.sport_id)

    prev_seasons = seasons.select { |s| s.year < @season.year }
    next_seasons = seasons.select { |s| s.year > @season.year }

    if prev_seasons.count > 0 
      @prev_season = prev_seasons.sort_by { |s| s.year }.last
    end

    if next_seasons.count > 0 
      @next_season = next_seasons.sort_by { |s| s.year }.first
    end

    @period_displays = Hash.new
    @away_display_data = Hash.new
    @home_display_data = Hash.new
    @away_winners = Hash.new
    @home_winners = Hash.new


    @schedule_events.each do |s|
  		if s.home_season_id == @season.id
			s.home_season = @season
			s.away_season = Season.find(s.away_season_id)  		
  		else
  			s.home_season = Season.find(s.home_season_id)
  			s.away_season = @season
  		end

      s.date = ActiveSupport::TimeZone.new(@season.school.tz_name).utc_to_local(s.date) # convert that date to local time

      home = @season == s.home_season
      us = if home then s.home_score else s.away_score end
      them = s.home_score + s.away_score - us
      
      if s.status == 1
        case s.period
          when 1
            period_display = "1st"
          when 2
            period_display = "2nd"
          when 3
            period_display = "Half"
          when 4
            period_display = "3rd"
          when 5
            period_display = "4th"
          when 6
            period_display = "OT"
        end
      elsif s.status == 2
        if s.period == 6
          period_display = "Final/OT"
        else
          period_display = "Final"
        end
      else
        period_display = "Preview"
      end

      @period_displays[s.id] = period_display
      @away_display_data[s.id] = "#{s.away_season.school.name};#{s.away_season.school.abbreviation}"
      @home_display_data[s.id] = "#{s.home_season.school.name};#{s.home_season.school.abbreviation}"
      @away_winners[s.id] = s.status == 2 && s.home_score < s.away_score
      @home_winners[s.id] = s.status == 2 && s.home_score > s.away_score

      @show_game = @schedule_events.first
      current = @schedule_events.select { |s| s.status == 1 }
      if current.count == 1
        @show_game = current.first
      end
  	end

    @possible_opponents = (Season.where(:year => @season.year, :sport_id => @season.sport_id) - [@season]).sort_by { |s| s.school.name }
    @prms = { "school" => @season.school.name, "sport" => @season.sport.to_string, "year" => @season.year }
    render :layout => "borderless"
  end

  def list
  	@team = Team.where(:school_id => params[:school_id], :sport_id => params[:sport_id]).first
  	@seasons = Season.where(:school_id => params[:school_id], :sport_id => params[:sport_id]).sort_by{ |s| s.year }.reverse
  
    @prms = { "school" => @team.school.name, "sport" => @team.sport.to_string }
  end

  def create
    t = Team.find(params[:team_id])
    if logged_in? && params[:team_id] && params[:season][:year]
      if school_admin?(t.school_id)
        begin
          y = Integer(params[:season][:year])
          if Season.where(:school_id => t.school_id, :sport_id => t.sport_id, :year => y).count == 0
            Season.create(:school_id => t.school_id, :sport_id => t.sport_id, :year => y)
          end
        rescue
        end
      end
    end

    redirect_to :action => :list, :school_id => t.school_id, :sport_id => t.sport_id
  end
end