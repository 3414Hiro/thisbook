class Recommendation < ActiveRecord::Base
  
  paginates_per 15
  
  default_scope -> { order(created_at: :desc) }
  
  belongs_to :user
  belongs_to :book
  
  attr_accessor :rakuten_data
    
  validates :comment, length: { maximum: 3000 }
end
