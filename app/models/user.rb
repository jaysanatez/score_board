class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, presence: true 
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false} 
	validates :password, presence: true, length: { minimum: 6 }

	attr_accessor :school
end

# role: 0 - GlobalAdmin, 1 - TeamAdmin
# school_id: 0 if not TeamAdmin, school_id if TeamAdmin