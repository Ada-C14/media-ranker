class Work < ApplicationRecord

  validates :title, presence: true, uniqueness: true
  validates :category, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true

  # relationship
  has_many :votes
  has_many :users, through: :votes

  def self.spotlight
    sort = all.sort do |a, b|
      vote_check = b.votes.count <=> a.votes.count
      !vote_check.zero? ? vote_check : a.title <=> b.title
    end
    sort.first
  end

  def self.top_ten(category)
    # top ten sort_by vote?
    return Work.where(category: category).sort_by { |work| work.votes.count }.first(10)
  end
end
