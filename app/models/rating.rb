class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  validates_inclusion_of :rating, in: 1..5
  
end
