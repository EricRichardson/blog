class User < ActiveRecord::Base
  has_secure_password
  has_many :posts, dependent: :nullify
  has_many :comments, dependent: :nullify
  has_many :favorites, dependent: :destroy
  has_many :favorited_posts, through: :favorites, source: :posts


  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
                    format: {with: VALID_EMAIL_REGEX},
                    unless: :using_oauth?
  validates :uid, uniqueness: {scope: :provider}, if: :using_oauth?

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.create_from_twitter(twitter_data)
    user = User.new
    full_name = twitter_data["info"]["name"].split(" ")
    user.first_name = full_name.first
    user.last_name = full_name.last
    user.uid = twitter_data["uid"]
    user.provider = twitter_data["provider"]
    user.twitter_token = twitter_data["credentials"]["token"]
    user.twitter_secret = twitter_data["credentials"]["secret"]
    user.twitter_raw_data = twitter_data
    user.password = SecureRandom.urlsafe_base64
    user.save!
    user
  end

  def self.find_or_create_from_twitter(twitter_data)
    user = User.where(uid: twitter_data["uid"], provider: twitter_data["provider"]).first
    user = create_from_twitter(twitter_data) unless (user)
    user
  end

  def using_oauth?
    uid.present? && provider.present?
  end

  PROVIDER_TWITTER = "twitter"
  def using_twitter?
    using_oauth? && provider == PROVIDER_TWITTER
  end

end
