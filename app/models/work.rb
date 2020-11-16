class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  validates :title, presence: true, uniqueness: true

  def self.get_spotlight
    return Work.left_joins(:votes)
               .group(:id)
               .order('COUNT(votes.work_id) DESC, works.title')
               .first
  end

  def self.get_top_ten(category)
    return Work.where(category: category)
               .left_joins(:votes)
               .group(:id)
               .order('COUNT(votes.work_id) DESC, works.title')
               .first(10)
  end
end
