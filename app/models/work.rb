class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: true, uniqueness: true
  validates :category, presence: true

  def self.select_spotlight
    spotlight = Work.all.sort_by{ |work| work.votes.count}.last
    return spotlight
  end

  def self.top_ten(category)
    works = Work.where(category: category)
    top_ten = works.all.sort_by{ |work| [work.votes.count, work.title]}.last(10)
    return top_ten.reverse!
  end
end
