class Work < ApplicationRecord
  validates :category, presence: true
  validates :title, presence: true, uniqueness: true
  has_many :votes, dependent: :destroy
  has_many :users, through: :votes

  def self.spotlight
    return Work.order("votes_count DESC, created_at").first
  end

  def self.top_ten(category)
    return Work.where(category: category).order("votes_count DESC, created_at").limit(10)
  end



end
