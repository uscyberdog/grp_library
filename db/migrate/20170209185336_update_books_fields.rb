class UpdateBooksFields < ActiveRecord::Migration[5.0]
  def change
  	remove_column :books, :photo_uri, :string
  	add_column :books, :gr_book_id, :string
  	add_column :books, :gr_avg_rating, :string
  	add_column :books, :num_pages, :string
  	add_column :books, :gr_link, :string
  	add_column :books, :book_cover_photo_med, :string
  	add_column :books, :book_cover_photo_sm, :string
  end
end
