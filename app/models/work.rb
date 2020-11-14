class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  
  has_many :votes
  has_many :users, through: :votes

  def total_votes
    return self.votes.count
  end

  def spotlight
    # work gets the most votes today
  end
end
