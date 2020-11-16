class Vote < ApplicationRecord
  validates :work_id, uniqueness: { scope: :user_id, message: "User cannot upvote work more than once"}

  belongs_to :work
  belongs_to :user

end
