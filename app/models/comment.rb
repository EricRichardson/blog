class Comment < ActiveRecord::Base
  validates :body, presence: true

  validates :body, uniqueness: true
  # validates_uniqueness_of :body, scope: :post_id
end
