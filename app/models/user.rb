class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable

  has_one :recommendation, dependent: :destroy
  has_one :book, through: :recommendation
  
  has_many :favorites, dependent: :destroy
  has_many :favorite_books, through: :favorites, source: :book
  
  mount_uploader :image, ImageUploader
  
  
  
  validates :bio, length: { maximum: 200 }
  
  # userがオススメの一冊を登録する
  def recommend(book, params)
    self.recommendation = self.build_recommendation(book_id: book.id, comment: params[:comment])
  end
  
  # userが他の人が紹介している本をお気に入りする
  def favorite(book)
    favorites.find_or_create_by(book_id: book.id)
  end
  
  # お気に入りを外す
  def unfavorite(book)
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorites.destroy if favorite
  end
  
  # お気に入りしているかどうか
  def favorite?(book)
    favorite_books.include?(book)
  end
  
end
