class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  # check that user hasn't voted before
  validates :work_id, presence: true, uniqueness: {scope: user_id}

  # validates :user_id, presence: true

end
