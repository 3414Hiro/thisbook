class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable

  has_one :recommendation
  has_one :book, through: :recommendation
  
  mount_uploader :image, ImageUploader
  
  validates :bio, length: { maximum: 200 }
end
