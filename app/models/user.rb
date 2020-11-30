class User < ApplicationRecord
  has_many :votes, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def user_votes
    if self.votes.size != 1
      return "#{self.votes.size} votes"
    else
      return "#{self.votes.size} vote"
    end
  end
end
