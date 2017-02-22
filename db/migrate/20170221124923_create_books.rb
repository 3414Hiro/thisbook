class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      # t.references :user, index: true, foreign_key: true
      t.string :title

      t.timestamps null: false
    end
    
    create_table :recommendations do |t|
      t.references :user, index: true, foreign_key: true
      t.references :book, index: true, foreign_key: true
      
      t.timestamps null: false
    end
  end
end
