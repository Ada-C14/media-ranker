class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :work_id, uniqueness: { scope: :user_id, message: "User has already voted for this work" }
end
