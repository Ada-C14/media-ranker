class User < ApplicationRecord
  validates :name, presence: true

  has_many :votes
  has_many :works, through: :votes

  def format_time
    return(self.created_at.strftime("%b %d, %Y"))
  end
end
