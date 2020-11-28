class User < ApplicationRecord

  has_many :votes
  has_many :works, through: :votes

  validates :username, presence: true
  validates :uid, uniqueness: { scope: :provider }

  def self.user_joined
    User.all.sort_by { |user| [user.votes.count, user.created_at] }.reverse
  end

  def self.build_from_github(auth_hash)
    user = User.new
    user.uid = auth_hash['uid']
    user.provider = auth_hash['provider']
    user.username = auth_hash['info']['nickname']
    user.email = auth_hash['info']['email']

    return user
  end
end
