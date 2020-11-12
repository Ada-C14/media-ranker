class Work < ApplicationRecord

  CATEGORIES = %w(album book movie) # For checkboxes on form partials // validations

  validates :category,  presence: true,
            inclusion: { in: CATEGORIES }

  validates :title, presence: true,
            uniqueness: { scope: :category }

  def self.by_category(category)
    self.where(category: category).order(category: :desc) #TODO: change order to vote count when initialized
  end

  def self.media_spotlight
    return Work.order('RANDOM()').first
  end

  def self.top_ten(category)
    return Work.by_category(category).order('RANDOM()').limit(10)
  end
end

