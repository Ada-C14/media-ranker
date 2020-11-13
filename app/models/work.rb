class Work < ApplicationRecord
  has_many :votes
  validates :category, presence: true, inclusion: { within: %w[movie book album] }
  validates :title, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true
  validates :description, presence: true
end
