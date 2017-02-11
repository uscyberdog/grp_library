class PersonalBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :book_id, uniqueness: true
end
