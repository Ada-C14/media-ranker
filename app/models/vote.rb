class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates_uniqueness_of :work_id, scope: :user_id
  # google validation to run only on creation (if user is deleted later)
  # or depend and destroy so if a user is deleted, the votes are gone too
end
