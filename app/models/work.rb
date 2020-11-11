class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  has_many :votes

  def self.select_spotlight
    # will this be in votes model?
    # this will change to pick the work with the highest votes
    spotlight = self.all.sample
    return spotlight
  end

  def self.select_top_ten
    movies = Work.where(category: "movie")
    albums = Work.where(category: "album")
    books = Work.where(category: "book")
    return movies, albums, books
  end

end
