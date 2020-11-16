class Work < ApplicationRecord
  has_many :votes #, through: :users

  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true
  validates :publication_year, presence: true, numericality: { only_integer: true }, length: { is: 4 }
  validates :description, presence: true

  def self.category_filter(category)
    return self.where(category: category)
  end

  def self.spotlight
    @works = Work.all

    max_voted = @works.max_by { |work| work.votes.count}
    return max_voted
  end

  def self.top10(category)
    @works = Work.all
    category_works = @works.category_filter(category)

    sorted = category_works.sort_by { |work| work.votes.count }.reverse
    if sorted.length < 10
      return sorted
    else
      return sorted[0..9]
    end
  end

end
