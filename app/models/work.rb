class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  
  has_many :votes
  has_many :users, through: :votes

  def total_votes(work)
    return work.votes.count
  end
end
