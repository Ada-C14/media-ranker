class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates_uniqueness_of :user_id, scope: :work_id, message: 'User has already voted for this work'
end
