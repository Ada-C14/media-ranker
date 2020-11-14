class User < ApplicationRecord

  has_many :votes
  has_many :works, through: :votes

  def self.get_session_user(session_id)
    User.find_by(id: session_id)
  end

  def self.user_joined
    User.all.sort_by { |user| [user.votes.count, user.created_at] }.reverse
  end

end
