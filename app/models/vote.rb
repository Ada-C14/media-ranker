class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  validates :work_id, uniqueness: true
end
