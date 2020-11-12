class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  def self.get_spotlight
    return Work.first
  end

  def self.get_top_ten(category)
    return Work.where(category: category).limit(10)
  end
end
