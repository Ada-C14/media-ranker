
class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true
  validates :category, presence: true


  def self.spotlight
    return Work.all.sample
  end

  def self.top_ten(works)
    return works.sample(10)
  end
end