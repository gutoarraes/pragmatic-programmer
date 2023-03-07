class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\S+@\S+/}

  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end

end
