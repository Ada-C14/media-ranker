class Work < ApplicationRecord
  validates :title, :creator, :publication_year, :description, presence: true
  validates :title, uniqueness: true
  validates :publication_year, numericality: true
  has_many :votes

  def self.top_10_works_in_category(work_category)
    # top = @works.select {|row| row.category == category}
    # top.sample(10)
    Work.where(category: work_category).sample(10)
  end

  def self.spotlight_selection
    spot = Work.all.sample(1)
    return spot
  end

  def self.works_in_category(work_category)
    Work.where(category: work_category)
  end

  # Method sorts the votes
  # def sort_vote
  #
  # end
end
