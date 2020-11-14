class Work < ApplicationRecord

  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: true

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
    Work.all.limit(1)[0]
  end

  def self.top_ten(category)
    Work.where(category: category).limit(10)
  end

end
