class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\S+@\S+/}

  validates :username, presence: true, uniqueness: { case_sensitive: false }

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, through: :favorites, source: :movie

  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end

end
