class ChangePubdateToDate < ActiveRecord::Migration[5.0]
  def change
  	remove_column :books, :pub_date, :integer
  	add_column :books, :pub_date, :date

  end
end
