class Work < ApplicationRecord
  has_many :votes
  has_many :users, through: :votes

  validates :title, presence: true, uniqueness: true

  CATEGORIES = %w(album book movie)

  def increase_vote_count
    self.vote_count += 1
    self.save
  end
end
