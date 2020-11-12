class Work < ApplicationRecord
  has_many :users, through: :votes

  validates :category, presence: true
  validates :title, :creator, :description, presence: true
  validates :publication_year, presence: true, numericality: { only_integer: true, less_than_or_equal_to: Date.today.year.to_i }


  def self.spotlight
    Work.all.limit(1)[0]
  end

  def self.top_ten(category)
    Work.where(category: category).limit(10)
  end


end
