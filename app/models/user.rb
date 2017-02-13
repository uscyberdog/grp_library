class User < ApplicationRecord
	has_secure_password
	has_many :personal_books
	has_many :books, through: :personal_books

	validates :email, uniqueness: true

	validates :fname, presence: { message: "(First name) field cannot be blank" }
	validates :lname, presence: { message: "(Last name) field cannot be blank" }

	validates_confirmation_of :password
  

	validates :password, confirmation: true
end
