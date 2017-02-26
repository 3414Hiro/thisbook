class BooksController < ApplicationController
  before_action :set_user
  
  def index
  end
  
  def new
    if params[:q]
      response = RakutenWebService::Books::Total.search(
        keyword: params[:q],
        imageFlag: 1,
      )
      @books = response.first(15)
    end
  end
  
  def destroy
  end
  
  private
  
  def set_user
    @user = current_user
  end
  
end
