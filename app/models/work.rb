class Work < ApplicationRecord
  has_many :users, through: :votes

  validates :title, presence: true
  validates :category, presence: true
  validates :publication_year, numericality: { only_integer: true, less_than_or_equal_to: Date.today.year.to_i + 3 }

  def self.spotlight
    return Work.all.sample
  end

  def self.top_movies
    movies = Work.where(category: "movie").limit(10)

    movies.empty? ? nil : movies
  end

  def self.top_albums
    albums = Work.where(category: "album").limit(10)

    albums.empty? ? nil : albums
  end

  def self.top_books
    books = Work.where(category: "book").limit(10)

    books.empty? ? nil : books
  end

  def self.all_movies
    movies = Work.where(category: "movie")

    movies.empty? ? nil : movies
  end

  def self.all_books
    books = Work.where(category: "book")

    books.empty? ? nil : books
  end

  def self.all_albums
    albums = Work.where(category: "album")

    albums.empty? ? nil : albums
  end
end
