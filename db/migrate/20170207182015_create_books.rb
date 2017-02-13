class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :author
      t.string :gr_author_id
      t.text :description
      t.integer :pub_date
      t.string :isbn
      

      t.timestamps
    end
  end
end
