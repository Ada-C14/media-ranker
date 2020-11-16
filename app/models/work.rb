class Work < ApplicationRecord
  validates :category, presence: true
  validates :title, presence: true

  has_many :votes
  has_many :users, through: :votes

  def self.sort_by_votes

  end

  def self.top_10(category)

  end

  def self.spotlight
    return self.sort_by_votes.first
  end
end
