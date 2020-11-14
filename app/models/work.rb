class Work < ApplicationRecord
  has_many :votes


  VALID_CATEGORIES = ['album', 'book', 'movie']

  validates :title, presence: true
  validates :title, uniqueness: true
  validates :category, presence: true, inclusion: {in: VALID_CATEGORIES}

  def self.top_by_category(category, count:10)
    if !VALID_CATEGORIES.include?(category)
      raise ArgumentError("Invalid category")
    end
    list = Work.where(category: category)
    top = list.sample(count)
    return top
  end

  def self.spotlight
    spotlight = Work.all.sample(1)
    return spotlight[0]
  end
end
