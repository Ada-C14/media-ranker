class Work < ApplicationRecord
  def top_ten(category)
    return Work.where(category: category).sample(10)
  end

  def media_spotlight
    return Work.all.sample
  end
end
