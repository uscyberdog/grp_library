class AddBookFields < ActiveRecord::Migration[5.0]
  def change
  	add_column :books, :title, :string
  	add_column :books, :photo_uri, :string

  end
end
