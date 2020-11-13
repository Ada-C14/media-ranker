class Work < ApplicationRecord
  has_many :votes
  validates :category, presence: true#, inclusion: { in: Work.category }
  validates :title, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true
  validates :description, presence: true
end
