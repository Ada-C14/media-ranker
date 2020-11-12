class Work < ApplicationRecord

  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :publication_date, presence: true, numericality: true
  validates :creator, presence: true
  validates :category, presence: true



end
