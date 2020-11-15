class User < ApplicationRecord

  has_many :votes
  has_many :works, through: :votes

  validates :username, presence: true

  def self.user_joined
    User.all.sort_by { |user| [user.votes.count, user.created_at] }.reverse
  end

end
