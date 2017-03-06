class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable

  has_one :recommendation, dependent: :destroy
  has_one :book, through: :recommendation
  
  mount_uploader :image, ImageUploader
  
  validates :bio, length: { maximum: 200 }
  
  # userがオススメの一冊を登録する
  def recommend(book, params)
    # r = if self.recommendation.present?
    #       self.recommendation
    #     else
    #       self.build_recommendation
    #     end
    # r.comment = params[:comment]
    # r.book_id = book.id
    # r.save
    self.recommendation = self.build_recommendation(book_id: book.id, comment: params[:comment])
  end
  
end
