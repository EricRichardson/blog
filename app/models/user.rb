class User < ActiveRecord::Base
  has_secure_password
  has_many :posts
  has_many :comments

  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
                    format: {with: VALID_EMAIL_REGEX}

  def full_name
    "#{first_name} #{last_name}"
  end
end
