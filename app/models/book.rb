class Book < ApplicationRecord
	has_many :personal_books
	has_many :users, through: :personal_books

	validates :title, presence: { message: " field is required" }
	validates :author, presence: { message: "field is required" }
	validates :isbn, presence: { message: " field is required" }
	validates :gr_book_id, uniqueness: true 
end
