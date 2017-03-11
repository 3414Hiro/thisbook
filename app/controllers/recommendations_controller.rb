class RecommendationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recommendation, only: [:edit, :update]
  
  def index
    @recommendations = Recommendation.order(:created_at).page params[:page]
    @recommendations.each do |recommendation|
      recommendation.rakuten_data = RakutenWebService::Books::Total.search(isbnjan: recommendation.book.isbn).first
    end
  end
  
  def newarrival
    @recommendations = Recommendation.order(:created_at).page params[:page]
    @recommendations.each do |recommendation|
      recommendation.rakuten_data = RakutenWebService::Books::Total.search(isbnjan: recommendation.book.isbn).first
    end
  end
  
  def new
    @book_data = RakutenWebService::Books::Total.search(isbnjan: params[:isbn]).first
    @recommendation = current_user.build_recommendation
  end
  
  def create
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
    redirect_to current_user
  end
  
  def edit
    @book_data = RakutenWebService::Books::Total.search(isbnjan: current_user.book.isbn).first
  end
  
  def update
    @recommendation.update(recommendation_params)
    redirect_to current_user
  end
 
  private

  
  def recommendation_params
    # {comment: 'aaaa'}
    params.require(:recommendation).permit(:comment)
  end
  
  def set_recommendation
    @recommendation = Recommendation.find(params[:id])
  end
end
