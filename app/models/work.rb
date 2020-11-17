class Work < ApplicationRecord
  validates :category, presence: true
  validates :title, presence: true

  has_many :votes
  has_many :users, through: :votes

  def self.sort_by_votes
    # in descending order
    return self.all.sort_by { |work| -work.votes.count }
  end

  def self.top_10(category)
    return self.where(category: category).sort_by_votes.first(10)
  end

  def self.spotlight
    return self.sort_by_votes.first
  end
end
