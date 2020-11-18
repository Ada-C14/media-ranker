class Work < ApplicationRecord

  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: true
  validates :description, presence: true
  validates :publication_date, presence: true, numericality: true
  validates :creator, presence: true
  validates :category, presence: true, inclusion: { in: %w(album book movie), message: "category must be a movie, book or album" }

  # def spotlight
  #   return self.sample
  # end
  #
  # def top_albums
  #   return self.where(category: 'album').sample(10)
  # end
  #
  # def top_books
  #   return self..where(category: 'book').sample(10)
  # end
  #
  # def top_movies
  #   return self..where(category: 'movie').sample(10)
  # end
end
