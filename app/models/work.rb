class Work < ApplicationRecord

  VALID_CATEGORIES  = %w[album book movie]
  validates :category, presence: true, inclusion: {in: VALID_CATEGORIES}
  validates :publication_year, presence: true, numericality: true
  validates :title, uniqueness: true
  validates :title, presence: true

  has_many :votes
  validates :title, presence: true, uniqueness: true

  def self.spotlight
    spotlight_for_all_works = Work.all.sample
    return spotlight_for_all_works
  end


end
