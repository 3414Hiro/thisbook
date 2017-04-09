class RankingsController < ApplicationController
  def index
    @books = Favorite.top10
    @books.each do |book|
      book.rakuten_data = RakutenWebService::Books::Total.search(isbnjan: book.isbn).first
    end
  end
end
