class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  def total_votes
  # total_votes = 0
  # all_votes = work.votes.count
  end
end
