class Work < ApplicationRecord

  validates :title, presence: true, uniqueness: { scope: [:category] }

  # for now, it takes a sample of 10 for the category
  def self.top_10(category)
      return self.where(category: category).sample(10)
  end

end
