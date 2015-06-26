class Team < ActiveRecord::Base
	belongs_to :school
	belongs_to :sport

	validates :school_id, :presence => true
	validates :sport_id, :presence => true

	def to_string
		return "#{school.name} - #{if sport.male then "Men's" else "Women's" end} #{sport.name}"
	end
end