class Work < ApplicationRecord

  has_many :votes
  has_many :users, through: :votes

  CATEGORIES = %w(album book movie) # For checkboxes on form partials // validations

  validates :category,  presence: true,
            inclusion: { in: CATEGORIES }

  validates :title, presence: true,
            uniqueness: { scope: :category }

  def self.by_category(category)
    if Work.all.any? { |work| work.category == category }
      self.where(category: category).order(votes_count: :asc)
    else
      output_message = "No #{category}s have been added to the system yet!"
      return output_message
    end
  end

  def self.media_spotlight
    if Work.all.empty?
      output_message = "No works have been added to the system yet!"
      return output_message
    else
      top_work = Work.find_by(votes_count: Work.maximum(:votes_count)) #https://stackoverflow.com/questions/4974049/ruby-on-rails-getting-the-max-value-from-a-db-column/4974069
      return top_work
    end
  end

  def self.top_ten(category)
    top_ten = where(category: category).order(votes_count: :asc).limit(10)

    if top_ten.empty?
      output_message = "No #{category}s have been added to the system yet!"
      return output_message
    else
      return top_ten
    end
  end
end

