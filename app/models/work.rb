class Work < ApplicationRecord
  #has_many ..

  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true
  validates :publication_year, presence: true, numericality: { only_integer: true }, length: { is: 4 }
  validates :description, presence: true

  def self.category_filter(category)
    return self.where(category: category)
  end

  def self.spotlight
    top10 = []
    10.times do
      top10 << Work.all.sample
    end
    return top10
  end

end
