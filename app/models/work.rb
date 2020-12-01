
class Work < ApplicationRecord

  validates :title, presence: true, uniqueness: true
  validates :category, presence: true
  validates :creator, presence: true

  has_many :votes



  def self.spotlight
    @works = Work.all

    max_votes = @works.max_by { |work| work.votes.count}
    return max_votes
  end

  def self.top_ten(works)
    return works.sample(10)
  end
end