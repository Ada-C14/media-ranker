class Work < ApplicationRecord
  validates :title, :creator, :publication_year, :description, presence: true
  validates :title, uniqueness: true
  validates :publication_year, numericality: true

  def self.top_10_works_in_category(work_category)
    # top = @works.select {|row| row.category == category}
    # top.sample(10)
    Work.where(category: work_category).sample(10)
  end

  def self.spotlight_selection
    spot = Work.all.sample(1)
    return spot
  end
end
