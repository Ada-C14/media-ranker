class Work < ApplicationRecord
  validates :title, :creator, :description, presence: true
  validates :category, presence: true, inclusion: { in: %w[movie book album],
              message: 'Category must be a movie, book, or album.'}

  validates :publication_year, presence: true,
            inclusion: { in: 1800..Date.today.year, message: 'Please pick a work created from 1800 onward.'},
            numericality: { only_integer: true, message: 'Please enter an year, from 1800 onward.'}

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
