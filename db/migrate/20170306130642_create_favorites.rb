class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :user, index: true
      t.references :book, index: true

      t.timestamps null: false
      
      t.index :user_id
      t.index :book_id
    end
  end
end
