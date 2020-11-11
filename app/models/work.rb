class Work < ApplicationRecord
  has_many :users, through: :votes

  validates :category, presence: true
  validates :title, presence: true
  # validates :creator, presence: true
  # validates :publication_year, numericality: { only_integer: true }
  # validates :description, presence: true

end