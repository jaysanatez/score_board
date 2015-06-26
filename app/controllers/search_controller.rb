class SearchController < ApplicationController
  def index
  	@schools = School.all.sort_by { |s| s.name }
  	@sports = Sport.all.sort_by { |s| s.name }
  end

  def query
  	@param = params[:query]

  	if !@param || @param == ""
  		redirect_to :action => :index
  	else
	  	@schools = School.all.select { |s| s.name.downcase.include? @param.downcase }.sort_by { |s| s.name }
	  	@sports = Sport.all.select { |s| s.name.downcase.include? @param.downcase }.sort_by { |s| s.name }
	  	render 'index'
  	end
  end
end