class Work < ApplicationRecord
  validates :category, presence: true
  validates :category, inclusion: { in: ["album", "book", "movie"],
                                    message: "category can only be album, book, or movie." }
  validates :title, presence: true, uniqueness: true

  has_many :votes
  has_many :users, through: :votes

  def top_10_albums
    albums = Work.all.where(category: "album")
    return albums.order(votes: :desc).limit(10)
  end

  def top_10_books
    books = Work.all.where(category: "book")
    return books.order(votes: :desc).limit(10)
  end

  def top_10_movies
    movies = Work.all.where(category: "movie")
    return movies.order(votes: :desc).limit(10)
  end

end
