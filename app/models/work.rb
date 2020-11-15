class Work < ApplicationRecord
  validates :category, presence: true
  validates :title, presence: true, uniqueness: { case_sensitive: false, scope: :category }

  has_many :votes
  has_many :users, through: :votes



end
