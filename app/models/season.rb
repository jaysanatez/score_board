class Season < ActiveRecord::Base
	belongs_to :sport
	belongs_to :school

	validates :year, :presence => true

	def to_string
		return "#{school.name} - #{if sport.male then "Men's" else "Women's" end} #{sport.name} - #{year}"
	end

	def school_name
		return school.name
	end
end
