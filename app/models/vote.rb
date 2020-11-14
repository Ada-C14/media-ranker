class Vote < ApplicationRecord

  validates :work_id, uniqueness: { scope: :user_id}

  belongs_to :work
  belongs_to :user
end
