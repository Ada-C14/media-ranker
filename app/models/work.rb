class Work < ApplicationRecord
  has_many :votes, dependent: :destroy

  validates :category, presence: true
  validates :title, presence: true, uniqueness: { scope: :category }

  def self.spotlight
    all_works = self.all
    all_works.max_by { |work| work.votes.size}
  end

  def self.top_ten(category)
    Work.where(category: category).sort_by { |work| work.votes.size }.reverse.first(10)
  end
end
