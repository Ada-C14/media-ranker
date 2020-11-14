class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates_uniqueness_of :work_id, scope: :user_id
  # work_id has to be unique relative to a user_id
end
