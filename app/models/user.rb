class User < ApplicationRecord
  has_many :votes, dependent: :delete_all

  validates :username, presence: true

  def vote_count
    return self.votes.count
  end
end
