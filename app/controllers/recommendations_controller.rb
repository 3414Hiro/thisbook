class RecommendationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  
  
  def new
    @book_data = RakutenWebService::Books::Total.search(isbnjan: params[:isbn]).first
    @recommendation = current_user.build_recommendation
  end
  
  def create
    binding.pry
    if current_user.book.present?
      b = current_user.book
      b.destroy if b
    end
    @book = Book.find_by(isbn: params[:isbn])
    if @book.blank?
      @book_data = RakutenWebService::Books::Total.search(isbnjan: params[:isbnjan]).first
      params = {
        isbn:  @book_data['isbn'],
        title: @book_data['title']
      }
      @book = Book.create(params)
    end
    current_user.recommend(@book, recommendation_params) #params[:comment])
    redirect_to @user
  end
  
  def edit
    @book_data = RakutenWebService::Books::Total.search(isbnjan: current_user.book.isbn).first
    @recommendation = current_user.recommendation
  end
  
  def update
    @book = Book.find_by(isbn: current_user.book.isbn)
    current_user.recommend(@book, recommendation_params)
    redirect_to @user
  end
  
  private
  
  def recommendation_params
    # {comment: 'aaaa'}
    params.require(:recommendation).permit(:comment)
  end
  
  def set_user
    @user = current_user
  end
end
