class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  
  has_many :votes
  has_many :works, through: :votes

  def each_user_votes
    return self.votes.count
  end
end
