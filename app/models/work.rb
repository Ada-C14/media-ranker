class Work < ApplicationRecord
  validates :category, presence: true
  validates :title, presence: true, uniqueness: true
  has_many :votes, dependent: :destroy
  has_many :users, through: :votes

  def self.spotlight
    return order("votes_count DESC, created_at").first
  end

  def self.top_ten(category)
    return Work.where(category: category).order("votes_count DESC, title").limit(10)
  end

  def single_or_plural_votes
    if votes_count == 1
      return "1 Vote"
    else
      return "#{votes_count} Votes"
    end
  end
end
