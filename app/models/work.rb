class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: true
  validates :category, presence: true

  def self.select_spotlight
    spotlight = Work.all.sort_by{ |work| work.votes.count}.last
    return spotlight
  end

  def self.top_ten(category)
    top_ten = Work.where(category: category).sample(10)
    # spotlight = Vote.order('work_id DESC').first

  end
end
