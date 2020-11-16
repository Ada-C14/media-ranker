class Work < ApplicationRecord
  has_many :votes, dependent: :delete_all

  validates :title, presence: true, uniqueness: {message: "must be unique"}
  validates :category, presence: true




end



