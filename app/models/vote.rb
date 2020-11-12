class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  # validates :work_id, uniqueness: { scope: :user_id } # I think this would not allow a user to vote for same media more than once
  validates :user_id, uniqueness: { scope: :work_id, message: "user: has already voted for this work" }
end
