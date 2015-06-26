class SportsController < ApplicationController
  def index
  	@sport = Sport.find(params[:id])
    @schools = @sport.schools.sort_by { |s| s.name }
    @possible_schools = (School.all - @sport.schools).sort_by { |s| s.name }

    @prms = { "sport" => @sport.to_string }
  end

  def list
  	@sports = Sport.all.sort_by { |s| s.name }
  end

  def create
	  if params[:sport][:name] && params[:sport][:male] && global_admin?
  		Sport.create(:name => params[:sport][:name], :male => params[:sport][:male])
  	end

  	redirect_to :action => :list
  end
end