class Post < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :ratings, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites

  validates :title, presence: true,
                    uniqueness: true

  validates :body, presence: true,
                   length: { minimum: 7 }

  scope :most_recent, -> {order(created_at: :desc).limit(6)}

  scope :search, -> (term) { where("body ILIKE :term OR title ILIKE :term", {term: "%#{ term }%"})}

  def self.paginate(current_page)
    per_page_count = 12
    page_num = current_page.to_i
    order(created_at: :desc).offset(per_page_count * (page_num - 1)).limit(per_page_count)
  end

  def body_snippet
    body.truncate(100)
  end

  def favorited_by?(user)
    favorites.exists?(user: user)
  end

  def favorite_for(user)
    favorites.find_by_user_id user
  end
end
