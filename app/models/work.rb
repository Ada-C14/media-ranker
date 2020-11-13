class Work < ApplicationRecord
  validates :title, presence: true
  validates :media, presence: true

  has_many :votes
  has_many :users, through: :votes
end
