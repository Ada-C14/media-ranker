class Work < ApplicationRecord
  has_many :votes, dependent: :delete_all # we can't delete users, so we'll only need it here
  has_many :users, through: :votes
  # before validating
  before_validation {self.category = category.downcase if !self.category.nil?} # presence catches a nil entry
  # validations
  validates :category, inclusion: { in: %w[book movie album], message: 'must be book, movie, or album'}
  validates :title, presence: true, uniqueness: {scope: :category, message: 'has already been taken'}
end
