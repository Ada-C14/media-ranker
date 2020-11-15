class Work < ApplicationRecord
  #has_many :users (that would be votes, I guess)

  validates :category, presence: true
  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true
  validates :publication_year, presence: true
  validates :description, presence: true


  def self.sort_by_category(category)
    self.where(category: category)
  end

end
