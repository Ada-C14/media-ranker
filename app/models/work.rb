class Work < ApplicationRecord
  CATEGORIES = ['album', 'book', 'movie']
  validates :title, presence: true, uniqueness: true
  validates :category, presence: true, inclusion: { in: CATEGORIES ,
            message: "%{value} is not a valid category" }
  validates :publication_year, numericality: { only_integer: true, allow_nil: true,
                                               allow_blank: true}

  def self.top_ten(category)
    return Work.where(category: category).sample(10)
  end

  def self.media_spotlight
    return Work.all.sample
  end
end 
