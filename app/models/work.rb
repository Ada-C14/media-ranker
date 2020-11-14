class Work < ApplicationRecord
  validates :name, presence: true

  has_many :votes
  has_many :users, through: :votes



end
