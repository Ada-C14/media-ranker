class Vote < ApplicationRecord
  validates :user_id, uniqueness: {scope: :work_id, message: "has already voted for this work"}

  belongs_to :user
  belongs_to :work

end
