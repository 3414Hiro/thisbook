class Book < ActiveRecord::Base
  
  
  has_many :recommendations, dependent: :destroy
  has_many :users, through: :recommendations
  
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  
  attr_accessor :rakuten_data
  # validates :user_id, presence: true
  validates :title, presence: true
  
  # def rakuten_data
  #   return @rakuten_date if @rakuten_data.present?
  #   binding.pry
  #   @rakuten_data = RakutenWebService::Books::Total.search(isbnjan: self[:isbn]).first
  #   @rakuten_data
  # end
  
  # book.rakuten = ~~~~~
  # def rakuten_data=(value)
  #   @# end
end
