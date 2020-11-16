class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  has_many :users, through: :votes

  validates :title, presence: true, uniqueness: { scope: :category }
  validates :category, presence: true

  def self.spotlight
    return Work.all.max_by { |work| work.votes.count}
  end

  def self.top_ten(category)
    return Work.where(category: category).sort_by { |work| work.votes.count }.reverse[0..9]
  end

  def self.sorted(category)
    return Work.where(category: category).sort_by { |work| work.votes.count }.reverse
  end

  def vote_date
    vote = Vote.find_by(work_id: self.id)
    return vote.created_at.strftime("%b %d, %Y")
  end
end
