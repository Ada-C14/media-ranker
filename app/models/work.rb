class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :category, presence: true, inclusion: {
      in: ["album", "book", "movie"],
      message: "not a valid category" }
  validates :title, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true
  validates :description, presence: true

  def self.category_organized(category)
    works = Work.all.where(category:category).order('votes_count DESC')
    return works
  end

  def self.top_ten(category)
    # works = Work.all.where(category:category).order('votes_count DESC').limit(10)
    works = self.category_organized(category).limit(10)
    return works
  end

  def self.spotlight
    return Work.order('votes_count DESC').limit(10)
  end

end
