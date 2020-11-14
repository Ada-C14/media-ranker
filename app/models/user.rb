class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  has_many :votes
  has_many :works, through: :votes

  def joined
    return self.created_at.strftime("%b %d, %Y")
  end
end
