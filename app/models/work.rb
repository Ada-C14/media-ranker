class Work < ApplicationRecord
  def self.top_by_category(category, count:10)
    list = find_by(category: category)
    return list.sample(count)
  end

  def self.spotlight
    spotlight = Work.all.sample(1)
    return spotlight
  end
end
