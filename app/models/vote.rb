class Vote < ApplicationRecord
  validates :work_id, uniqueness: { scope: user_id }, :message => "User has already voted for this work"
end
