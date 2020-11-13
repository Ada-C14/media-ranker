class Work < ApplicationRecord

  validates :title, presence: true, uniqueness: { scope: [:category] }

  has_many :votes

  # for now, it takes a sample of 10 for the category
  def self.top_10(category)
      return self.where(category: category).sample(10)
  end

  #for now, the spotlight is based on the oldist publication year
  def self.spotlight
    works = self.all.filter {|work| !(work.publication_year.nil?)}
    return works.min_by { |work| work.publication_year}
  end

end
