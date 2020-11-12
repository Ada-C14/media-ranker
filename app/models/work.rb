class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes
  # before validating
  before_validation {self.category = category.downcase if !self.category.nil?} # presence catches a nil entry
  # validations
  validate :valid_title
  validates :category, inclusion: { in: %w[book movie album], message: 'must be book, movie, or album'}
  validates :title, presence: true

  def valid_title
    same_category = Work.where(category: self.category).pluck(:title)
    if same_category.include?(self.title)
      errors[:title] << 'has already been taken'
    end
  end
end
