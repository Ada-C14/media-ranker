class Work < ApplicationRecord
  # has_many :users, through: :votes
  validates :title, presence: true
  validates :category, presence: true

  def self.select_spotlight
    spotlight = Work.all.sample
    return spotlight
  end

  def self.top_ten(category)
    top_ten = Work.where(category: category).sample(10)
  end
end
