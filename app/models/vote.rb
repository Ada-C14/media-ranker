class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work


  validates :work_id, presence: true, uniqueness: { scope: :user_id, message: "User has already upvoted this work" }

end
