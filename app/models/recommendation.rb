class Recommendation < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
    
  validates :comment, length: { maximum: 3000 }
end
