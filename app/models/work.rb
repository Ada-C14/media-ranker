class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: true, uniqueness: {case_sensitive: false}

  def self.spotlight
    works = Work.all
    max = works.max_by { |work| work.votes.count }
    return max
  end

  def self.top_ten(category:)
    works = Work.all.where(category: category)
    works = works.sort_by do |work|
     work.votes.count
    end.reverse.first(10)
  end

  def self.total_lists(category:)
    works = Work.all.where(category: category)
    works.sort_by do |work|
      work.votes.count
    end.reverse
  end
end


