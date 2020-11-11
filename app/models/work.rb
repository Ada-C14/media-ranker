class Work < ApplicationRecord
  def self.spotlight
    return Work.all.sample
  end

  def self.top_ten(category)
    return Work.where(category: category).sample(10)
  end
end
