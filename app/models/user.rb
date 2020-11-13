class User < ApplicationRecord
  has_many :works, through: :votes
  has_many :votes

  validates :username, presence: true
end
