class Work < ApplicationRecord

  validates :category,
            presence: true,
            inclusion: { in: %w(movie book album), message: "Category must be a movie, book, or album." }
  validates :title, :creator, :description, presence: true
  validates :publication_year,
            presence: true,
            :numericality => { :greater_than_or_equal_to => 0 }

  def self.media_spotlight
    Work.all.limit(1)[0]
  end

  def self.top_ten(category)
    Work.where(category: category).limit(10)
  end

end
