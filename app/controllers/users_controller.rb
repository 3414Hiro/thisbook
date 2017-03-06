class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    # @image = MiniMagick::Image.open("input.jpg")
    #binding.pry
    if @user.book.present?
      @book_data = RakutenWebService::Books::Total.search(isbnjan: @user.book.isbn).first
    end
  end
  
end
