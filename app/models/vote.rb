class Vote < ApplicationRecord

  validates :work_id, uniqueness: { scope: :user_id, message: "has already voted for this work"}

  belongs_to :work
  belongs_to :user
end
