class UsersController < ApplicationController
  before_action :set_user, only: [:show, :favorites]
 

  def show
    if @user.book.present?
      @book_data = RakutenWebService::Books::Total.search(isbnjan: @user.book.isbn).first
    end
  end
  
  def favorites
    # binding.pry
    @books = @user.favorite_books
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
end
