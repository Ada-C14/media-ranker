class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :user_id, presence: true
  validates :work_id, presence: true
  validates_uniqueness_of :user_id, scope: :work_id
end
