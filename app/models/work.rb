class Work < ApplicationRecord
  def self.top_ten(category)
    return Work.where(category: category).sample(10)
  end

  def self.media_spotlight
    return Work.all.sample
  end
end 
