class Work < ApplicationRecord
  has_many :votes, dependent: :destroy

  validates :category, presence: true
  validates :title, presence: true, uniqueness: { scope: :category }

  def self.spotlight
  end

  def self.top_ten(category)
  end
end
