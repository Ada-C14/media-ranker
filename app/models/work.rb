class Work < ApplicationRecord

  VALID_CATEGORIES  = %w[album book movie]
  validates :category, presence: true, inclusion: {in: VALID_CATEGORIES}
  validates :publication_year, presence: true, numericality: true
  validates :title, uniqueness: true
  validates :title, presence: true


end
