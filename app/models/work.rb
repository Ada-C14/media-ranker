class Work < ApplicationRecord
  #has_many ..

  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true
  validates :publication_year, presence: true, numericality: { only_integer: true }, length: { is: 4 }
  validates :description, presence: true
end
