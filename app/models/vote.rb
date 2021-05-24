class Vote < ApplicationRecord
  belongs_to :work, counter_cache: true
  belongs_to :user

  validates :work_id, uniqueness: { scope: :user_id, message: "• user: has already voted for this work" }
end


