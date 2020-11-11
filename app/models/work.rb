class Work < ApplicationRecord
  validates :title, presence: true
  validates :title, uniqueness: true

  def self.top_by_category(category, count:10)
    if category.nil?
      return "There is no item of this category"
    else
      list = Work.where(category: category)
      top = list.sample(count)
      return top
    end
  end

  def self.spotlight
    spotlight = Work.all.sample(1)
    return spotlight[0]
  end
end
