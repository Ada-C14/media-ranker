class Work < ApplicationRecord
  validates :title, presence: true
  validates :category, presence: true
  validates :publication_year, numericality: { only_integer: true, less_than_or_equal_to: Date.today.year.to_i + 3 }

  def self.spotlight
    return Work.all.sample
  end

  def self.top_movies
    return Work.where(category: "movie").limit(10)
  end

  def self.top_albums
    return Work.where(category: "album").limit(10)
  end

  def self.top_books
    return Work.where(category: "book").limit(10)
  end

  def self.all_movies
    return Work.where(category: "movie")
  end

  def self.all_books
    return Work.where(category: "book")
  end

  def self.all_albums
    return Work.where(category: "album")
  end
end
