class User < ApplicationRecord
  validates :name, presence: true
  validates :date_joined, presence: true
  has_many :works, through: :votes
  has_many  :votes

  def num_votes
    return self.votes.count
  end
end
