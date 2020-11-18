class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true
  validates :category, presence: true


  def self.spotlight
    return Work.all.max_by { |work| work.votes.count }
  end

  def self.top_ten(cat)
    works = Work.all.where(category: cat).sort_by { |work| work.votes.count }.reverse!
    return works.take(10)
  end

end

