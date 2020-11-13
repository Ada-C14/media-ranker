class Work < ApplicationRecord

  CATEGORIES = %w(album book movie) # For checkboxes on form partials // validations

  validates :category,  presence: true,
            inclusion: { in: CATEGORIES }

  validates :title, presence: true,
            uniqueness: { scope: :category }

  def self.by_category(category)
    if Work.all.any? { |work| work.category == category }
      self.where(category: category).order(category: :desc) #TODO: change order to vote count when initialized
    else
      output_message = "No #{category}s have been added to the system yet!"
      return output_message
    end
  end

  def self.media_spotlight
    if Work.all.nil?
      output_message = "No works have been added to the system yet!"
      return output_message
    else
      return Work.order('RANDOM()').first
    end
  end

  def self.top_ten(category)
    if Work.by_category(category).nil?
      output_message = "No #{category}s have been added to the system yet!"
      return output_message
    else
      return Work.by_category(category).order('RANDOM()').limit(10)
    end
  end
end

