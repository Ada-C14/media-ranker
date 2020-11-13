class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true

  has_many :votes
  has_many :works, through: :votes

  def works
    works = []
    votes.each do |vote|
      works << vote.work
    end

    return works
  end
end
