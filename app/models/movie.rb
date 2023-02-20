class Movie < ApplicationRecord

  def self.released
    Movie.where("released_on > ?", 1500).order("released_on DESC")
  end

  def flop?
    total_gross.blank? || total_gross < 225_000_000
  end

end
  