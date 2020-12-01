
class Work < ApplicationRecord

  validates :title, presence: true, uniqueness: true
  validates :category, presence: true
  validates :creator, presence: true

  has_many :votes



  def self.spotlight
    return Work.all.sample
  end

  def self.top_ten(works)
    return works.sample(10)
  end
end