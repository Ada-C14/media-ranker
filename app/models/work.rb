class Work < ApplicationRecord
  validates :category, inclusion: { in: %w(album book movie)}
  validates :title, presence: true, uniqueness: true
  validates :publication_year, numericality: { only_integer: true }, allow_nil: true

  has_many :votes
  has_many :users, through: :votes

  def users
    users = []
    votes.each do |vote|
      users << vote.user
    end

    return users
  end

  def self.top_ten
    @top_albums = Work.where(category: "album").sample(10)
    @top_books = Work.where(category: "book").sample(10)
    @top_movies = Work.where(category: "movie").sample(10)

    tops = {
        albums: @top_albums,
        books: @top_books,
        movies: @top_movies
    }

    return tops
    # TODO this will be replaced with the top ten vote getters
    # in each category
    # once votes are things that exist
  end

  def self.spotlight
    works = Work.all
    @spotlight = works.sample
    # TODO this will be replaced with the top vote getter
    # once votes are things that exist
  end
end
