class Work < ApplicationRecord
  validates :category, presence: true
  validates :title, presence: true, uniqueness: true
  has_many :users, through: :votes

  def self.spotlight
    return Work.all.sample
  end

  def self.top_ten(category)
    return Work.where(category: category).sample(10)
  end
end
