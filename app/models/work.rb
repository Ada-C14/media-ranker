class Work < ApplicationRecord
  has_many :votes

  validates :category, presence: true
  validates :title, presence: true

  def self.top_ten(category)
    works = Work.all.where(category:category)
    return works.max_by(10) { |work| work.votes.count }
  end

  def self.spotlight
    return Work.all.max_by {|work| work.votes.count}
  end
end