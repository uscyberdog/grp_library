class CreatePersonalBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :personal_books do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.text :comment

      t.timestamps
    end
  end
end
