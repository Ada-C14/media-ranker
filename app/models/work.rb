
class Work < ApplicationRecord

  validates :title, presence: true, uniqueness: true
  validates :category, presence: true

  has_many :votes
  belongs_to :creator
  has_and_belongs_to_many :genres


  def self.spotlight
    return Work.all.sample
  end

  def self.top_ten(works)
    return works.sample(10)
  end
end