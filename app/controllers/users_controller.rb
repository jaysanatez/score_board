class UsersController < ApplicationController
	def index
		if global_admin?
			@global_admin = User.where(:role => 0)
			@team_admin = User.where(:role => 1)
			@team_admin.each do |a|
				a.school = School.find(a.school_id)
			end
			@possible_roles = ["Global Admin", "Team Admin"]
			@possible_schools = School.all  
		elsif logged_in?
			@team_admin = User.where(:school_id => current_user.school_id)
			@team_admin.each do |a|
				a.school = School.find(a.school_id)
			end
			@possible_roles = ["Team Admin"]
			@possible_schools = [@team_admin.first.school]
		end
	end

	def create
		p = params[:user]
		if logged_in? && p[:role] && p[:school] && p[:name] && p[:email] && p[:password]
			r = if p[:role] == "Global Admin" then 0 else 1 end
			s_id = if r == 0 then 0 else p[:school].to_i end
			User.create(:name => p[:name], :email => p[:email], :password => p[:password], :role => r, :school_id => s_id)
		end

		redirect_to :action => :index
	end

	def delete
		u = User.find(params[:user_id])
		if global_admin? || school_admin?(u.school_id)
			u.destroy
		end

		redirect_to :action => :index
	end
end