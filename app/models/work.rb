class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes
  validates :title, presence: true
  validates :category, presence: true
  validates :publication_year, presence: true
  validates :creator, presence: true


end
