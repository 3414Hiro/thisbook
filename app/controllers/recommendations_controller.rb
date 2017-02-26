class RecommendationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  
  def create
    if params[:isbn_code]
      @book = Book.find_or_initialize_by(isbnjan: params[:isbn_code])
    else
      @book = Book.find(params[:book_id])
    end
    
    if @book.new_record?
      books = RakutenWebService::Books::Total.search(isbnjan: params[:isbn_code])
      
      book                  = items.first
      @book.title           = item['title']
      @book.auther          = item['author']
      @book.small_image     = item['smallImageUrls'].first['imageUrl']
      @book.medium_image    = item['mediumImageUrls'].first['imageUrl']
      @book.large_image     = item['mediumImageUrls'].first['imageUrl'].gsub('?_ex=128x128', '')
      @book.detail_page_url = item['itemUrl']
      @book.save!
    end
    
    current_user.recommendation(@book)
  end
  
  def edit
  end
  
  private
  
  def set_user
    @user = current_user
  end
end
