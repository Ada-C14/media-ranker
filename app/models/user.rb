class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :date_joined, presence: true
  has_many  :votes

  def num_votes
    return self.votes.count
  end
end
