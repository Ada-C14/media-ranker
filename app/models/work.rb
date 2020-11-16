class Work < ApplicationRecord
  has_many :votes, dependent: destroy
  has_many :users, through: votes

  validates :category, presence: true
  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true
  validates :publication_year, presence: true
  validates :description, presence: true


  def self.sort_by_category(category)
    self.where(category: category)
  end

  def self.top_ten(category)
    works = Work.sort_by_category(category)
    top_ten = works.sort_by {|work| -work.votes.count}
    return top_ten
  end

  def self.spotlight
    works = Work.all
    spotlight = works.max_by {|work| work.votes.length}
    return spotlight
  end
end
