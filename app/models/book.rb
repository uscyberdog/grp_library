class Book < ApplicationRecord
	has_many :personal_books
	has_many :users, through: :personal_books

	validates :title, presence: { message: "Title field is required" }
	validates :author, presence: { message: "Author field is required" }
	validates :isbn, presence: { message: "ISBN field is required" }
end
