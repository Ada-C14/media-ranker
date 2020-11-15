class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :category, presence: true, inclusion: {
      in: ["album", "book"],
      message: "not a valid category" }
  validates :title, presence: true
  validates :creator, presence: true
  validates :publication_year, presence: true
  validates :description, presence: true


  # work method to figure out top 10 for each
end
