class Work < ApplicationRecord
  validates :category, inclusion: { in: %w(album book movie)}
  validates :title, presence: true, uniqueness: true
  validates :publication_year, numericality: { only_integer: true }, allow_nil: true

end
