class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: true, uniqueness: true

  CATEGORIES = %w(album book movie)

  # def spotlight
  #
  # end
  #
  # def top_ten(array_of_works)
  #   array_of_works.select { |work| work.votes }
  # end
  #
  # def users_that_voted
  #   users = []
  #   votes.each do |vote|
  #     users += user.votes
  #   end
  # end
end
