class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :category, presence:true
  validates :title, presence: true, uniqueness: true

  def self.top_ten(category)
    work = Work.all.where(category: category)
    return work.max_by(10){|work| work.votes.count}
  end

  def self.spotlight
    return Work.all.sample.title
  end

end
