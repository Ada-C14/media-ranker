class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: true
  validates :category, presence: true
  validates :publication_year, presence: true
  validates :creator, presence: true

  def self.sort_votes
    work = Work.all
    sorted_work = work.sort_by{|work| work.votes.count}.reverse
    return sorted_work
  end

  def self.spotlight
    work = Work.all
    spotlight = work.sort_votes.first
    return spotlight
  end

  def self.top_ten
    work = Work.all
    top_ten = work.sort_votes
    return top_ten
  end
end
