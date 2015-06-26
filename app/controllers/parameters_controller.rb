class ParametersController < ActionController::Base
  def redirect
  	prms = params[:prms]
  	prm_clear = params[:clear]

    if prms.has_key?("school")
      school = School.select { |s| s.name == prms["school"] }.first
    end

    if prms.has_key?("sport")
      sport = Sport.select { |s| s.to_string == prms["sport"] }.first
    end

    if prms.count > 2
      season = Season.select { |s| s.year == prms["year"].to_i && s.school_id == school.id && s.sport_id == sport.id }.first
    end


    if prms.count == 1
      if prm_clear == "school"
        redirect_to :controller => :schools, :action => :list
      else
        redirect_to :controller => :sports, :action => :list
      end
    elsif prms.count == 2
      if prm_clear == "school"
        redirect_to :controller => :sports, :action => :index, :id => sport.id
      else
        redirect_to :controller => :schools, :action => :index, :id => school.id
      end
    elsif prms.count == 3
      if prm_clear == "year"
        redirect_to :controller => :seasons, :action => :list, :school_id => school.id, :sport_id => sport.id
      else
        if prm_clear == "school"
        redirect_to :controller => :sports, :action => :index, :id => sport.id
        else
          redirect_to :controller => :schools, :action => :index, :id => school.id
        end
      end
    elsif prms.count == 4
      if prm_clear == "opponent"
        redirect_to :controller => :seasons, :action => :index, :id => season.id
      elsif prm_clear == "year"
        redirect_to :controller => :seasons, :action => :list, :school_id => school.id, :sport_id => sport.id
      elsif prm_clear == "school"
        redirect_to :controller => :sports, :action => :index, :id => sport.id
      else
        redirect_to :controller => :schools, :action => :index, :id => school.id
      end
    end

  end
end