class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  
  has_many :votes
  has_many :users, through: :votes

  def total_votes
    return self.votes.count
  end

  def self.index_order(category)
    return self.where(category: category).joins(:votes).group("works.id").order("count_all desc, works.updated_at desc").count
  end

  def self.spotlight
    return self.joins(:votes).group("works.id").order("count_all desc, works.updated_at desc").count.first
  end
  
  def self.top_ten(category)
    return self.where(category: category).joins(:votes).group("works.id").order("count_all desc, works.created_at desc").count.take(10)
  end

  def self.top_ten_helper(work_id)
    return self.find_by(id: work_id)
  end
end
