class Work < ApplicationRecord

  validates :title, presence: true
  validates :category, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true

  # relationship
  has_many :votes
  has_many :users, through: :votes

  def top_ten(category)
    top_ten_list = Work.where(category: category)
    return top_ten_list
  end
end
