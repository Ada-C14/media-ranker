class Work < ApplicationRecord
    validates :title, presence: true
    validates :creator, presence: true
    validates :publication_year, numericality: { only_integer: true }
    validates :description, presence: true

end
