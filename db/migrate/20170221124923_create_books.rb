class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      # t.references :user, index: true, foreign_key: true
      t.string :title, null: false
      t.string :isbn,  null: false
      t.timestamps null: false
    end
    add_index :books, :isbn, unique: true
    
    create_table :recommendations do |t|
      t.references :user, index: true, foreign_key: true
      t.references :book, index: true, foreign_key: true
      t.text       :comment
      t.timestamps null: false
    end
  end
end
