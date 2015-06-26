module SessionsHelper
	def log_in(user)
		session[:user_id] = user.id
	end

	def log_out
		session.delete(:user_id)
		@current_user = nil
	end

	def current_user
		@current_user ||= User.find_by(:id => session[:user_id])
	end

	def logged_in?
		!current_user.nil?
	end

	def global_admin?
		return !current_user.nil? && current_user.role == 0
	end

	def school_admin?(school_id)
		return !current_user.nil? && (current_user.role == 0 || current_user.school_id == school_id)
	end
end