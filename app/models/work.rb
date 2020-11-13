class Work < ApplicationRecord

  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: true
  validates :description, presence: true
  validates :publication_date, presence: true, numericality: true
  validates :creator, presence: true
  validates :category, presence: true, inclusion: { in: %w(album book movie), message: "category must be a movie, book or album" }

end
