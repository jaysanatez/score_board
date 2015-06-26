class TeamsController < ApplicationController
	def create
		if params[:school_id]
			if params[:school_id] && params[:team][:sport_id] && school_admin?(params[:school_id])
				sch = School.find(params[:school_id])
				sp = Sport.find(params[:team][:sport_id])
				if sch && sp
					Team.create(:school_id => params[:school_id], :sport_id => params[:team][:sport_id])
				end
			end
			redirect_to :controller => :schools, :action => :index, :id => params[:school_id]
		elsif params[:sport_id]
			if params[:sport_id] && params[:team][:school_id] && global_admin?
				sch = School.find(params[:team][:school_id])
				sp = Sport.find(params[:sport_id])
				if sch && sp
					Team.create(:school_id => params[:team][:school_id], :sport_id => params[:sport_id])
				end
			end
			redirect_to :controller => :sports, :action => :index, :id => params[:sport_id]
		end
	end
end