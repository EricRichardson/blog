class Tag < ActiveRecord::Base
  has_many :taggings, dependent: :destroy

  validates :title, presence: true, uniqueness: true
end
