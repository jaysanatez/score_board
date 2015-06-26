class School < ActiveRecord::Base
	has_many :teams
	has_many :sports, :through => :teams

	validates :name, presence: true
	validates :abbreviation, presence: true, length: { maximum: 4 }
end