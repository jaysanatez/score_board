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
	  if params[:sport][:name] && params[:sport][:male] != nil && global_admin?
      name = params[:sport][:name]
      male = Integer(params[:sport][:male]) == 1

      if Sport.where(:name => name, :male => male).count == 0
  		  Sport.create(:name => name, :male => male)
      end
  	end

  	redirect_to :action => :list
  end
end