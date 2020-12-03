class User < ApplicationRecord
  has_many :votes
  #has_many :works, through: :votes

  validates :name, presence: true, uniqueness: true


  def num_votes
    return self.votes.count
  end
end
