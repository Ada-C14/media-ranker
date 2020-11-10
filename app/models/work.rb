class Work < ApplicationRecord

  def self.media_spotlight
    Work.all.limit(1)[0]
  end

  def self.top_ten(category)
    Work.where(category: category).limit(10)
  end

end
