class Work < ApplicationRecord

  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: true, uniqueness: {scope: :category}
  validates :description, presence: true
  validates :publication_date, presence: true, numericality: true
  validates :creator, presence: true
  validates :category, presence: true, inclusion: { in: %w(album book movie), message: "category must be a movie, book or album" }

  def spotlight
    Work.all.order(vote_count: :desc).first
  end

  def top_albums
    order_media("album").limit(10)
  end

  def top_books
    order_media("book").limit(10)
  end

  def top_movies
    order_media("movie").limit(10)
  end

  def self.order_media(category)
    where(category: category).order(vote_count: :desc)
  end

end
