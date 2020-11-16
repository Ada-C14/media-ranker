class Work < ApplicationRecord
  has_many :votes

  validates :title, presence: true
  validates :category, presence: true


  def self.spotlight
    return Work.all.sample
  end

  # def self.spotlight
  #   return Work.all.max_by {|work| work.votes.count}
  # end

  def self.top_ten(cat)
    works = Work.all.where(category: cat)
    return works.sample(10)
  end

end

