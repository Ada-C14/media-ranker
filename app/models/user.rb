class User < ApplicationRecord
  has_many :votes
  has_many :works, through: :votes

  validates :username,
            presence: true,
            uniqueness: true

  def vote
    # work =
    # user = User.find_by(id: session[:user_id])
    # user.votes << Vote.create()
  end
end
