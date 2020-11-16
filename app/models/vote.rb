class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :user, presence: true

  # validates :work_id, uniqueness: { scope: :user_id, message: "User cannot vote on the same media more than once." }

end
