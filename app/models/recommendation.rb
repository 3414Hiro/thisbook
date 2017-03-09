class Recommendation < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  
  attr_accessor :rakuten_data
    
  validates :comment, length: { maximum: 3000 }
end
