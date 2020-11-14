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
    Work.all.sort_by { |work| work.votes.count }.reverse[0]
  end

  def self.top_ten(category)
    Work.where(category: category).sort_by { |work| work.votes.count }.reverse[0..9]
  end
end
