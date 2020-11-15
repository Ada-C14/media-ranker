class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  
  has_many :votes
  has_many :users, through: :votes

  def total_votes
    return self.votes.count
  end

  def self.index_order(category)
    return self.joins("LEFT JOIN votes on votes.work_id = works.id").where(category: category).group("works.id").order("count_votes_work_id desc, works.created_at desc").count("votes.work_id")
  end

  def self.spotlight
    return self.joins("LEFT JOIN votes on votes.work_id = works.id").group("works.id").order("count_votes_work_id desc, works.created_at desc").count("votes.work_id").first
  end
  
  def self.top_ten(category)
    return self.joins("LEFT JOIN votes on votes.work_id = works.id").where(category: category).group("works.id").order("count_votes_work_id desc, works.created_at desc").count("votes.work_id").take(10)
  end

  def self.top_ten_helper(work_id)
    return self.find_by(id: work_id)
  end
end
