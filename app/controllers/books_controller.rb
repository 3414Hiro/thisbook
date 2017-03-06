class BooksController < ApplicationController
  before_action :set_user, only: [:new]
  
  def index
    @books = Book.all
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
