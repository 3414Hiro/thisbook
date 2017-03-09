class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
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
    
    if recommendation.present?
      recommendation.update(book_id: book.id, comment: params[:comment])
    else
      self.recommendation = self.build_recommendation(book_id: book.id, comment: params[:comment])
    end
  end
  
  # userが他の人が紹介している本をお気に入りする
  def favorite(book)
    favorites.find_or_create_by(book_id: book.id)
  end
  
  # お気に入りを外す
  def unfavorite(book)
    f = favorites.find_by(book_id: book.id)
    f.destroy if f.present?
  end
  
  # お気に入りしているかどうか
  def favorite?(book)
    favorite_books.include?(book)
  end
  
end
