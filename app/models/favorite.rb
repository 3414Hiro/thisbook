class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  
  def self.top10
    top(10)
  end
  
  def self.top(limit)
    hash = limit(limit).group(:book_id).order('count_book_id desc').count(:book_id)
    book_ids = hash.keys
    books = Book.find(book_ids)
    books = books.sort_by{|book| book_ids.index(book.id) }
  end
  
   attr_accessor :rakuten_data
end
