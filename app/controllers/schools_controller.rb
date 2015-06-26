class SchoolsController < ApplicationController
  def index
  	@school = School.find(params[:id])
    @sports = @school.sports.sort_by { |s| s.name }
    @possible_sports = (Sport.all - @school.sports).sort_by { |s| s.name }

    @prms = { "school" => @school.name }
  end

  def list
  	@schools = School.all.sort_by { |s| s.name }
    @time_zones = ActiveSupport::TimeZone.us_zones
  end

  def create
    p = params[:school]

    uploaded_io = p[:picture]
    File.open(Rails.root.join('app', 'assets', 'images', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end

  	if p[:name] && p[:location] && p[:abbreviation] && p[:tz_name] && global_admin?
  		School.create(:name => p[:name], :abbreviation => p[:abbreviation], :location => p[:location], :tz_name => p[:tz_name], :picture => uploaded_io.original_filename)
  	end

  	redirect_to :action => :list
  end
end