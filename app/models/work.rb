class Work < ApplicationRecord

  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: true, uniqueness: {scope: :category}

  validates :category, presence: true

  validates :publication_year, presence: true,
             numericality: { greater_than: 1800, less_than:  Date.current.year + 1 }


  def self.albums
    where(category: "album").sort_by { |album| album.votes.count }.reverse[0..9]
  end

  def self.books
    where(category: "book").sort_by { |book| book.votes.count }.reverse[0..9]
  end

  def self.movies
    where(category: "movie").sort_by { |movie| movie.votes.count }.reverse[0..9]
  end

  def self.media_spotlight
    Work.all.sort_by { |work| work.votes.count }.reverse[0]
  end

  def self.top_ten(category)
    Work.where(category: category).sort_by { |work| work.votes.count }.reverse[0..9]
  end
end
