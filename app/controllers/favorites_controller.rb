class FavoritesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @book = Book.find(params[:book_id])
    current_user.favorite(@book)
  end
  
  def destroy
    @book = current_user.favorites.find(params[:id]).book
    current_user.unfavorite(@book)
  end
end
