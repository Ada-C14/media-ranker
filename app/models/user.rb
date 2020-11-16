class User < ApplicationRecord
  has_many :votes, dependent: delete_all
  # has_many :works, through: :votes

  validates :username, presence: true

  def vote_count
    return self.votes.count
  end
end
