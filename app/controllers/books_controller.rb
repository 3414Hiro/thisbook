class BooksController < ApplicationController
  before_action :set_user, only: [:new]
  
  def index
    @books = Book.all
    params[:search] = { keyword: 'Ruby' }
    @books = @books.search(params[:search])
    @books.each do |book|
      book.rakuten_data = RakutenWebService::Books::Total.search(isbnjan: book.isbn).first
    end
  end
  
  def new
    if params[:q]
      response = RakutenWebService::Books::Total.search(
        keyword: params[:q],
        imageFlag: 1,
        booksGenreId: '001'
      )
      @books = response.first(15)
    end
  end
  
  private
  
  def set_user
    @user = current_user
  end
  
end
