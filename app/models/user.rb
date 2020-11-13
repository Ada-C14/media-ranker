class User < ApplicationRecord
  has_many :votes
  has_many :works, through: :votes

  validates :username,
            presence: true,
            uniqueness: true

  def self.get_session_user(session_id)
    User.find_by(id: session_id)
  end
end
