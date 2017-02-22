class Book < ActiveRecord::Base
  has_many :recommendations
  has_many :users, through: :recommendations
  
  # validates :user_id, presence: true
  validates :title, presence: true
end
