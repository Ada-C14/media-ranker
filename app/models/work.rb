class Work < ApplicationRecord
  def self.top_by_category(category, count:10)
    list = Work.where(category: category)
    top = list.sample(count)
    return top
  end

  def self.spotlight
    spotlight = Work.all.sample(1)
    return spotlight[0]
  end
end
