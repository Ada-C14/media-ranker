class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  
  has_many :votes
  has_many :works, through: :votes

  def each_user_votes
    return self.votes.count
  end
  
  def order_voted_works
    return self.votes.order(created_at: :desc)
  end

  def self.index_order
    return self.order(id: :asc)
  end
end
