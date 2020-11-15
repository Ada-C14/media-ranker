class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  CATEGORIES = %w(album book movie)
end
