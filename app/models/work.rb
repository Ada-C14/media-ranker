class Work < ApplicationRecord

  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: true

  validates :publication_year, presence: true, numericality: { greater_than: 1900, less_than:  Date.current.year + 1 }
  def self.albums
    where(category: "album")
  end

  def self.books
    where(category: "book")
  end

  def self.movies
    where(category: "movie")
  end

  def self.media_spotlight
    Work.all.sort_by { |work| work.votes.count }.reverse[0]
  end

  def self.top_ten(category)
    Work.where(category: category).sort_by { |work| work.votes.count }.reverse[0..9]
  end
end
