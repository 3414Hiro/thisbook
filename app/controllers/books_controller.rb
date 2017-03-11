class BooksController < ApplicationController
  
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
  
end
