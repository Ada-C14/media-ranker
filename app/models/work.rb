class Work < ApplicationRecord
  validates :category, presence: true
  validates :title, presence: true
  validates :creator, presence: true
  validates :publication_date, presence: true
  validates :description, presence: true

  # def top_ten
  #   ran =
  #   return ran
  # end
end
