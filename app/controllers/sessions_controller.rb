class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to :controller => :home, :action => :index
    else
      render :layout => "login"
    end
  end

  def create
  	user = User.find_by(:email => params[:session][:email].downcase, :password => params[:session][:password])
  	if user
  		log_in(user)
  		redirect_to :controller => :home, :action => :index
  	else
  		flash[:error] = 'Invalid email/password combination'
  		redirect_to :action => :new
  	end
  end

  def destroy
  	log_out
  	redirect_to :action => :new
  end
end
