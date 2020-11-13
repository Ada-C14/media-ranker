class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  # scope: allow just one user
  validates :work_id, presence: true, uniqueness: { scope: user_id }
  validates :user_id, presence: true
end
