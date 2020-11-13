class Work < ApplicationRecord
  has_many :votes, dependent: :delete_all # we can't delete users, so we'll only need it here
  has_many :users, through: :votes
  # before validating
  before_validation {self.category = category.downcase if !self.category.nil?} # presence catches a nil entry
  # validations
  validates :category, inclusion: { in: %w[book movie album], message: 'must be book, movie, or album'}
  validates :title, presence: true, uniqueness: {scope: :category, message: 'has already been taken'}

  def self.sort_cat(category)
    return Work.where(category: category).sort_by{ |work| [-work.votes.count, work.title.downcase] }
  end

  def self.spotlight
    return Work.all.empty? ? nil : Work.all.sort_by{ |work| [-work.votes.count,
                                                             work.title.downcase,
                                                             DateTime.now - work.updated_at.to_datetime] }.first
  end

  def self.work_hash
    return { movies: Work.sort_cat('movie'),
             books: Work.sort_cat('book'),
             albums: Work.sort_cat('album')}
  end
end
