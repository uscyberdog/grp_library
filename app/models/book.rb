class Book < ApplicationRecord
	has_many :personal_books
	has_many :users, through: :personal_books
end
