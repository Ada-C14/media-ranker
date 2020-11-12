class Vote < ApplicationRecord
  validates :votes, uniqueness: {scope: [:work_id, :user_id]}
  belongs_to :work
  belongs_to :user
end
