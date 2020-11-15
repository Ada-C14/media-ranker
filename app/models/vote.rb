class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  # check that user hasn't voted before
  validates :work.id, presence: true, uniqueness: {scope: user.id}

  # validates :user_id, presence: true

end
