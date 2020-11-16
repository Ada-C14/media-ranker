class Work < ApplicationRecord
  validates :title, :creator, :publication_year, :description, presence: true
  validates :title, uniqueness: true
  validates :publication_year, numericality: true
  has_many :votes

  def self.top_10_works_in_category(work_category)
    cat_works = Work.where(category: work_category)
    top = cat_works.max_by(10) { |each| each.votes.count}
    return top
  end
  # top = @works.select {|row| row.category == category}
  # top.sample(10)

  def self.spotlight_selection
    spot = Work.all.max_by(1) { |each| each.votes.count}
    return spot
  end

  def self.works_in_category(work_category)
    cat_works = Work.where(category: work_category)
    all_ordered = cat_works.max_by(self.count)  { |each| each.votes.count}
    return all_ordered
  end

end
