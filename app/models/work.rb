class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  has_many :users, through: :votes

  validates :category,
            presence: true,
            inclusion: {
                in: %w[movie book album],
                message: 'Category must be a movie, book, or album.'
            }
  validates :title, :creator, :description, presence: true
  validates :publication_year,
            presence: true,
            inclusion: {
                in: 1800..Date.today.year,
                message: 'Please pick a work created from 1800 onward.'
            },
            numericality: {
                only_integer: true,
                message: 'Please enter an integer value for year, from 1800 onward.'
            }

  def self.media_spotlight
    Work.order('votes_count DESC, created_at')[0].votes_count.blank? ? nil : Work.order('votes_count DESC, created_at')[0]
  end

  def self.top_ten(category)
    Work.where(category: category).order('votes_count DESC, created_at')[0..9]
  end

  def self.sort_by_votes(category)
    Work.where(category: category).order('votes_count DESC, created_at')
  end
end
