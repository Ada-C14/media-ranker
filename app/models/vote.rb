class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates_presence_of :user, :work

  validates_uniqueness_of :user, scope: :work, message: "has already voted for this work"
  # google validation to run only on creation (if user is deleted later)
  # or depend and destroy so if a user is deleted, the votes are gone too
end
