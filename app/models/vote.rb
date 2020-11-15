class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates_presence_of :user_id, :work_id

  validates_uniqueness_of :user, scope: :work, message: "has already voted for this work"
end
