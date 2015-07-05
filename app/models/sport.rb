class Sport < ActiveRecord::Base
	has_many :teams
	has_many :schools, :through => :teams

	validates :name, presence: true 
	validates :male, :inclusion => {:in => [true, false]} 

	def to_string
		return "#{name} - #{if male then "Men's" else "Women's" end}" 
	end
end