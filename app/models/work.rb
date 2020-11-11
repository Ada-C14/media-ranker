class Work < ApplicationRecord
  def self.top_by_category(category, count:10)
    list = []
    list << Work.find_by(category: category)
    top = list.sample(count)
    return top
  end

  def self.spotlight
    spotlight = Work.all.sample(1)
    return spotlight
  end
end
