class Movie < ApplicationRecord

  has_many :reviews, dependent: :destroy

  validates :title, :duration, :released_on, presence: true

  validates :description, length: { minimum: 25 }

  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }

  validates :image_file_name, format: {
    with: /\w+\.(jpg|png)\z/i,
    message: "must be a JPG or PNG image"
}

RATINGS = %w(G PG PG-13 R NC-17)

  validates :rating, inclusion: { in: RATINGS, message: "not a valid rating"}


  def self.released
    Movie.where("released_on > ?", 1500).order("released_on DESC")
  end

  def flop?
    total_gross.blank? || total_gross < 225_000_000
  end

  def average_stars
    reviews.average(:stars) || 0.0
  end
end

