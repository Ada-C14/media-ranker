class Work < ApplicationRecord
  def self.albums
    where(category: "album")
  end

  def self.books
    where(category: "book")
  end

  def self.movies
    where(category: "movie")
  end
end
