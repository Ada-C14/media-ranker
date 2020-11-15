class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  
  has_many :votes
  has_many :works, through: :votes

  def each_user_votes
    return self.votes.count
  end
  
  def user_order_for_a_work
    return self.votes.order(date: :desc, created_at: :desc)
  end

  def self.index_order
    return self.order(joined: :desc)
  end
end
