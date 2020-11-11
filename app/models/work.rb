class Work < ApplicationRecord
  validates :category, presence: true
  validates :title, presence: true, uniqueness: true
end
