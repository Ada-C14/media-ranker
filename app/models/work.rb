class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :category, presence: true, inclusion: {
      in: ["album", "book", "movie"],
      message: "not a valid category" }
  validates :title, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true, numericality: { only_integer: true , greater_than: 1500 , less_than: 2100 , message: "must be valid"}
  validates :description, presence: true


  def self.category_organized(category)
    works = Work.all.where(category:category).order('votes_count DESC')
    return works
  end

  def self.top_ten(category)
    works = self.category_organized(category).limit(10)
    return works
  end

  def self.spotlight
    return Work.order('votes_count DESC').first
  end

end
