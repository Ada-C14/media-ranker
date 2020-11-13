class Work < ApplicationRecord
  has_many :votes, dependent: :delete_all

  validates :title, presence: true
  validates :category, presence: true
  validates :publication_year, numericality: { only_integer: true, less_than_or_equal_to: Date.today.year.to_i + 3 }

  def self.spotlight
    return Work.joins(:votes).group(:id).order('COUNT(votes.id)').last
  end

  def self.sort_by_vote_count
    works = self.left_joins(:votes).group(:id).order(Arel.sql('COUNT(votes.id)DESC'))
    works.blank? ? nil : works
  end

  def self.top_works(category)
    works = Work.where(category: category).sort_by_vote_count

    works.blank? ? nil : works.limit(10)
  end
end
